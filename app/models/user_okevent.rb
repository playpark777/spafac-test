class UserOkevent < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :reservation

  validates :user_id, presence: true
  validates :start, presence: true, date: { after: Time.zone.now.yesterday.end_of_day, message: "は今日以降に設定して下さい" }
  validate :check_date

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(active: true) }
  scope :not_opened, -> { where(active: false) }
  scope :not_me, -> id { where.not(id: id) }
  scope :around_month, -> first_day_of_month do
    where(arel_table[:start].gteq first_day_of_month - 15.day)
    .where(arel_table[:end].lteq first_day_of_month + 1.month + 15.day)
  end
  scope :disable_date?, -> date do
    opened
    .where(arel_table[:start].lteq date.beginning_of_day)
    .where(arel_table[:end].gteq date.end_of_day)
  end

  before_destroy :check_delete

  def check_date
    if self.reason == "holiday"
      # 同じ日に許可日[holiday]状態のデータ登録は禁止
      if UserOkevent.exists?(start: self.start, reason: "holiday", user_id: self.user_id)
        errors.add(:start, "に既に指定されています。")
      end
    elsif self.reason == "reserved"
      # 許可日[holiday]に含まれない日への予約[reserved]データ登録は禁止
      okevents = self.listing.listing_okevents
      unless okevents.pluck(:start).include?(self.start)
        errors.add(:base, "予約が可能な日付ではありません")
      end
    end
  end

  # リスティングカレンダー設定削除時のみに使用するvalidate用メソッド
  def check_delete
    if self.reason == "reserved"
      errors.add(:base, "削除ができないデータです。")
    elsif !self.aftertime?
      errors.add(:base, "編集可能なデータは明日以降のデータです。")
    elsif self.reserved?
      errors.add(:base, "既に予約された日の許可日削除は出来ません。")
    end
    return false if errors.present?
  end

  def reserved?
    UserOkevent.exists?(listing_id: self.listing_id, start: self.start, active: true, reason: "reserved")
  end

  def self.open_date?(reservation)
    if UserOkevent.exists?(listing_id: reservation.listing_id, start: reservation.schedule.strftime("%Y-%m-%d 15:00:00"))
      true
    else
      false
    end
  end

  # @return [1st date, 2nd date, 3rd date, ..., last date]
  def consecutive_days
    (self.start.to_date .. self.end.to_date).to_a
  end

  # 2015-10-03 00:00:00.000000 -> 2015-10-02 23:59:59.999999
  # @return self
  def convert_end_of_day
    self.start = self.start.beginning_of_day
    self.end   = (self.end - 1.day).end_of_day
    self
  end

  # @return [Tue, 29 Sep 2015, Wed, 30 Sep 2015, Thu, 01 Oct 2015, Sun, 11 Oct 2015, Mon, 12 Oct 2015 ... ]
  def self.ok_days( ngevent_id, user_id, listing_id = nil )
    oks = UserOkevent.opened.not_me(ngevent_id).mine(user_id)
    oks = oks.where(listing_id: listing_id) if listing_id
    oks.map( &:consecutive_days ).flatten
  end

  def aftertime?
    if self.start > (Time.zone.now)
      return true
    else
      return false
    end
  end
  # Usage
  #   Listing.where(UserNgevent.enable_search_condition( Time.now ).exists.not).opened
  #
  # @params date Datetime
  # @return Arel::SelectManager
  def self.enable_search_condition( date )
    listings = Listing.arel_table
    okevents = UserOkevent.arel_table
    condition = okevents
      .project(Arel.star)
      .where(arel_table[:active].eq true)
      .where(arel_table[:start].lteq date)
      .where(arel_table[:end].gt date)
      .where(listings[:id].eq( okevents[:listing_id] ))
  end

  # @return [Thu, 31 Aug 2017, Fri, 01 Sep 2017, Thu, 31 Aug 2017, Thu, 31 Aug 2017, ・・・・・・]
  def self.get_reservable_days(listing_id)
    sql = "select
     start,
     sum(case when reason = 'holiday'  then 1 else 0 end)
       as holiday,
     sum(case when reason = 'reserved' then 1 else 0 end)
       as reserved
     from user_okevents
     where listing_id = #{listing_id}
     group by start"

    results = ActiveRecord::Base.connection.select_all(sql).to_hash

    ok_days = []
    results.each do |result|
      holiday_sum = result["holiday"].to_i
      reserved_sum = result["reserved"].to_i
      if holiday_sum > reserved_sum
        ok_day = (result["start"].to_date + 1.day)
        ok_days << ok_day
      end
    end
    ok_days
  end
end
