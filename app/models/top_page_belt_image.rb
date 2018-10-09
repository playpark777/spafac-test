class TopPageBeltImage < ActiveRecord::Base
  include TopPageModules

  mount_uploader :image, DefaultImageUploader

  validates :image_flg, inclusion: { in: [true, false] }
  validates :tagline_ja, presence: true
  validates :sub_tagline_ja, presence: true
  validates :tagline_en, presence: true
  validates :sub_tagline_en, presence: true
  # validates :tagline_zh_cn, presence: true
  # validates :sub_tagline_zh_cn, presence: true
  validates :link_url, presence: true

  def tagline
    set_tagline
  end

  def sub_tagline
    set_sub_tagline
  end

  def link_url_has_app_domain?
    link_url_matches_app_domain?
  end
end
