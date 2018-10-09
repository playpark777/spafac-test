class Tool < ActiveRecord::Base
  belongs_to :listing

  validates :listing_id, presence: true
  validates :name, presence: true

  mount_uploader :image, DefaultImageUploader

  scope :mine, -> listing_id { where(listing_id: listing_id) }
  scope :order_asc, -> { order('order_num asc') }
  scope :records, -> listing_id { where(listing_id: listing_id) }
end
