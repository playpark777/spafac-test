class ProfileImage < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile

  mount_uploader :image, DefaultImageUploader

  validates :user_id, presence: true
  validates :profile_id, presence: true
  validates :image, presence: true
  #validates :order_num, numericality: {
  #  only_integer: true,
  #  equal_to: 0 # set has_one association
  #}

  scope :mine, -> user_id { where( user_id: user_id ) }

  def self.minimun_requirement?(user_id, profile_id)
    profile_image = ProfileImage.where(user_id: user_id, profile_id: profile_id).first
    if profile_image.present?
      if profile_image.image.present?
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
