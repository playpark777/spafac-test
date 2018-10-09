class BankAccountType < ActiveRecord::Base
  has_many :bank_accounts

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :availables, -> { where available: true }
end
