class ListingPv < ActiveRecord::Base
  belongs_to :listing

  validates :listing_id, presence: true
  validates :viewed_at, presence: true

  scope :weekly, -> { order('viewed_at desc').limit(7) }

  def self.add_count(listing_id)
    lp = ListingPv.find_or_initialize_by(listing_id: listing_id, viewed_at: Time.zone.now.to_date)
    if lp.pv.blank?
      lp.pv = 1
    else
      lp.pv += 1
    end
    lp.save
  end

  def self.weekly_pv(listing_id)
    result = 0
    hoge = ListingPv.where(listing_id: listing_id).weekly
    hoge.each do |h|
      result += h.pv
    end
    result
  end
end
