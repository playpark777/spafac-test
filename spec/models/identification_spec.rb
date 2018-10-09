require 'rails_helper'

describe Identification do
  let(:identification) { FactoryBot.create(:approved_identification) }

  subject { identification }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :profile_id }
  #it { is_expected.to validate_presence_of :image1 }

  it "belongs to profile" do
    profile = Profile.find(identification.profile_id)
    expect(identification.profile).to eq profile
  end

  it "belongs to admin_user as processed_by" do
    admin_user = AdminUser.find(identification.processed_by_id)
    expect(identification.processed_by).to eq admin_user
  end

  it "belongs to identification_type" do
    id_type = IdentificationType.find(identification.identification_type_id)
    expect(identification.identification_type).to eq id_type
  end
end
