class UserNgevent < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :reservation

  validates :user_id, presence: true
  validates :start_at, presence: true, date: { after: Time.zone.now.yesterday.end_of_day, message: "は今日以降に設定して下さい" }
  validates :end_at, presence: true, date: { after: :start_at }
  validate do |event|
    ng_days = UserNgevent.ng_days(event.id, event.user_id, event.listing_id)
    unless (event.consecutive_days & ng_days).size.zero?
      errors.add(:ng_days, 'NGevent is already exists at this day')
    end
  end

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(active: true) }
  scope :not_opened, -> { where(active: false) }
  scope :not_me, -> id { where.not(id: id) }
  scope :around_month, -> first_day_of_month do
    where(arel_table[:start_at].gteq first_day_of_month - 15.day)
    .where(arel_table[:end_at].lteq first_day_of_month + 1.month + 15.day)
  end
  scope :disable_date?, -> date do
    opened
    .where(arel_table[:start_at].lteq date.beginning_of_day)
    .where(arel_table[:end_at].gteq date.end_of_day)
  end

  # @return [1st date, 2nd date, 3rd date, ..., last date]
  def consecutive_days
    (self.start_at.to_date .. self.end_at.to_date).to_a
  end

  # 2015-10-03 00:00:00.000000 -> 2015-10-02 23:59:59.999999
  # @return self
  def convert_end_of_day
    self.start_at = self.start_at.beginning_of_day
    self.end_at   = (self.end_at - 1.day).end_of_day
    self
  end

  # @return [Tue, 29 Sep 2015, Wed, 30 Sep 2015, Thu, 01 Oct 2015, Sun, 11 Oct 2015, Mon, 12 Oct 2015 ... ]
  def self.ng_days( ngevent_id, user_id, listing_id = nil )
    ngs = UserNgevent.opened.not_me(ngevent_id).mine(user_id)
    ngs = ngs.where(listing_id: listing_id) if listing_id
    ngs.map( &:consecutive_days ).flatten
  end

  # Usage
  #   Listing.where(UserNgevent.enable_search_condition( Time.now ).exists.not).opened
  #
  # @params date Datetime
  # @return Arel::SelectManager
  def self.enable_search_condition( date )
    listings = Listing.arel_table
    ngevents = UserNgevent.arel_table
    condition = ngevents
      .project(Arel.star)
      .where(arel_table[:active].eq true)
      .where(arel_table[:start_at].lteq date)
      .where(arel_table[:end_at].gt date)
      .where(listings[:id].eq( ngevents[:listing_id] ))
  end

end
