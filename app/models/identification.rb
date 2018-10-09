class Identification < ActiveRecord::Base
  belongs_to :profile
  belongs_to :processed_by, class_name: 'AdminUser'
  belongs_to :identification_type

  delegate :user, to: :profile

  enum status: %w(not_yet approved rejected)

  mount_uploader :image1, DefaultImageUploader
  mount_uploader :image2, DefaultImageUploader
  mount_uploader :image3, DefaultImageUploader

  validates :profile_id, presence: true
  validates :image1, presence: true
end
