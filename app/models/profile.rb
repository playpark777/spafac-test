class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :profile_image, dependent: :destroy
  has_one :profile_video, dependent: :destroy
  has_one :identification, dependent: :destroy
  has_one :bank_account, dependent: :destroy

  enum gender: { female: 0, male: 1, others: 2, not_specified: 3 }

  validates :user_id, presence: true

  def full_name
    if I18n.locale == :ja
      return "#{last_name} #{first_name}"
    else
      return "#{first_name} #{last_name}"
    end
  end

  def self.minimun_requirement?(user_id)
    profile = Profile.where(user_id: user_id).first
    if profile.first_name.present? &&
      profile.last_name.present? &&
      profile.birthday.present? &&
      profile.phone.present? &&
      profile.location.present? &&
      profile.self_introduction.present?
      return true
    else
      return false
    end
  end
end
