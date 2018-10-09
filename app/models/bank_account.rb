class BankAccount < ActiveRecord::Base
  belongs_to :profile
  belongs_to :bank
  belongs_to :type_of_bank_account, class_name: 'BankAccountType',
    foreign_key: 'type_of_bank_account_id'

  validates :profile, presence: true
  validates :bank, presence: true
  validates :branch_code, presence: true
  validates :branch_name, presence: true
  validates :type_of_bank_account, presence: true
  validates :number, presence: true
  validates :name, presence: true
end
