class Auth < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :provider, presence: true
  validates :provider, inclusion: { in: %w(facebook) }
  validates :uid, presence: true
  validates :uid, uniqueness: true
  validates :access_token, presence: true
  validates :access_token, uniqueness: true
end
