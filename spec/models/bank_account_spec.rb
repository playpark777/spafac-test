require 'rails_helper'

describe BankAccount do
  let(:bank_account) { FactoryBot.create(:bank_account) }

  subject { bank_account }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :profile }

  it 'belongs to profile' do
    profile = Profile.find(bank_account.profile_id)
    expect(bank_account.profile).to eq profile
  end

  it 'belongs to bank' do
    bank = Bank.find(bank_account.bank_id)
    expect(bank_account.bank).to eq bank
  end

  it 'belongs to bank account type' do
    bank_account_type = BankAccountType.find(bank_account.type_of_bank_account_id)
    expect(bank_account.type_of_bank_account).to eq bank_account_type
  end
end
