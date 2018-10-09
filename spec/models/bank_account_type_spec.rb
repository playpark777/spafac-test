require 'rails_helper'

describe BankAccountType do
  let(:bank_account_type) { BankAccountType.new(name: "普通", available: true) }

  subject { bank_account_type }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :name }


  describe "availables scope" do
    it "returns availables bank account types" do
      unavailable_type = BankAccountType.create(
        name: "unavailable", available: false
      )
      expect(BankAccountType.availables).not_to include(unavailable_type)
    end
  end
end
