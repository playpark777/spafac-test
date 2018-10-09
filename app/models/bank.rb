class Bank < ActiveRecord::Base
  has_many :bank_accounts

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :code, presence: true
  validates :code, uniqueness: true

  scope :availables, -> { where available: true }
end
