class BrowsingHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :user_id, presence: true
  validates :listing_id, presence: true

  def self.insert_record(user_id, listing_id)
    BrowsingHistory.create(
      user_id: user_id,
      listing_id: listing_id,
      viewed_at: Time.zone.now.to_date
    )
  end
end
