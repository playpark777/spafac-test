class TopPageCoverTagline < ActiveRecord::Base
  include TopPageModules

  validates :tagline_ja, presence: true
  validates :sub_tagline_ja, presence: true
  validates :tagline_en, presence: true
  validates :sub_tagline_en, presence: true
  # validates :tagline_zh_cn, presence: true
  # validates :sub_tagline_zh_cn, presence: true

  def tagline
    set_tagline
  end

  def sub_tagline
    set_sub_tagline
  end
end
