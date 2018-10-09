require 'rails_helper'

describe User do
  let(:user) { FactoryBot.create(:user) }

  subject { user }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it "has one profile" do
    expect(user).to respond_to(:profile)
  end

  it "has one profile image" do
    expect(user).to respond_to(:profile_image)
  end

  it "has one profile video" do
    expect(user).to respond_to(:profile_video)
  end

  it "has many listings" do
    expect(user).to have_many(:listings)
  end

  it "has many message_thread_users" do
    expect(user).to have_many(:message_thread_users)
  end

  it "has many message_threads" do
    expect(user).to have_many(:message_threads)
  end

  it "is invalid with a invalid email address" do
    user.email = "invalid@bulbcorp,com"
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    duplicate_email_user = FactoryBot.build(:user, email: user.email)
    expect(duplicate_email_user).not_to be_valid
  end

  describe ".user_id_to_profile_id" do
    it "returns correct user id" do
      user_id = user.id
      profile_id = Profile.find_by(user_id: user_id).id
      expect(User.user_id_to_profile_id(user_id)).to eq profile_id
    end
  end
end
