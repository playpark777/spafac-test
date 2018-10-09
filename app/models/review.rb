class Review < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'host_id'
  belongs_to :user, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :listing
  belongs_to :reservation
  has_one :review_reply

  validates :guest_id, presence: true
  validates :host_id, presence: true
  validates :reservation_id, presence: true
  validates :listing_id, presence: true
  validates :msg, presence: true
  validates :accuracy, presence: true
  validates :communication, presence: true
  validates :cleanliness, presence: true
  validates :location, presence: true
  validates :check_in, presence: true
  validates :cost_performance, presence: true
  validates :total, presence: true

  scope :this_listing, -> listing_id { where(listing_id: listing_id) }
  scope :order_by_created_at_desc, -> { order('reviews.created_at desc') }
  scope :order_by_updated_at_desc, -> { order('reviews.updated_at desc') }
  scope :i_do, -> user_id { where(guest_id: user_id) }
  scope :they_do, -> user_id { where(host_id: user_id) }

  def calc_average
    self.calc_ave_of_listing
    self.calc_ave_of_profile
  end

  def calc_ave_of_listing
    l = Listing.find(self.listing_id)
    r_count = Review.where(listing_id: self.listing_id).count
    ave_total = (l.ave_total + self.total) / r_count
    l.ave_total = ave_total
    l.save
  end

  def calc_ave_of_profile
    prof = Profile.find_by(user_id: host_id)
    r_count = Review.where(host_id: self.host_id).count
    ave_total = (prof.ave_total + self.total) / r_count
    prof.ave_total = ave_total
    prof.save
  end
end
