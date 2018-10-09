require 'rails_helper'

describe Profile do
  let(:user) { FactoryBot.create(:user) }
  let(:profile) { user.profile }

  subject { profile }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :user_id }

  it "belongs to user" do
    expect(profile).to be user.profile
  end

  it "has one profile image" do
    expect(profile).to have_one(:profile_image)
  end

  it "has one profile video" do
    expect(profile).to have_one(:profile_video)
  end

  describe '#full_name' do
    it 'is return a correct value' do
      if I18n.locale == :ja
        full_name = "#{profile.last_name} #{profile.first_name}"
      else
        full_name = "#{profile.first_name} #{profile.last_name}"
      end
      expect(profile.full_name).to eq full_name
    end
  end
end
