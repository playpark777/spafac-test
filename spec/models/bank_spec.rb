require 'rails_helper'

describe Bank do
  let(:bank) { Bank.new(name: "三井住友銀行", code: "0009") }

  subject { bank }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :code }

  describe "availables scope" do
    it "returns availables banks" do
      unavailable_bank = Bank.create(
        name: "unavailable", available: false
      )
      expect(Bank.availables).not_to include(unavailable_bank)
    end
  end
end
