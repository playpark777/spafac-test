class TopPageDiscoveryImage < ActiveRecord::Base
  include TopPageModules

  mount_uploader :image, DefaultImageUploader

  validates :image, presence: true
  validates :tagline_ja, presence: true
  validates :tagline_en, presence: true
  # validates :tagline_zh_cn, presence: true
  validates :link_url, presence: true
  validates :order_num, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, uniqueness: true
  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :show_price, inclusion: { in: [true, false] }

  scope :order_by_order_num_asc, -> { order('order_num asc') }

  def tagline
    set_tagline
  end

  def link_url_has_app_domain?
    link_url_matches_app_domain?
  end
end
