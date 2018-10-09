class Inquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, class_name: 'AdminUser', foreign_key: 'admin_user_id'

  enum status: %w(open resolved pending)

  validates :title, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :body, presence: true
  validates :status, presence: true
  validates :user_agent, length: { minimum: 0, allow_nil: false, message: "nil is unacceptable." }
  validates :remote_ip, length: { minimum: 0, allow_nil: false, message: "nil is unacceptable." }
end
