class TopPageCoverImage < ActiveRecord::Base

  mount_uploader :image, DefaultImageUploader

  validates :image, presence: true
  validates :order_num, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, uniqueness: true

  scope :order_by_order_num_asc, -> { order('order_num asc') }
end
