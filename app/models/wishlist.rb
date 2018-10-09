class Wishlist < ActiveRecord::Base
  belongs_to :user, counter_cache: :wishlist_count
  has_many :favorites, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
end
