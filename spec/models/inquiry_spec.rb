require 'rails_helper'

describe Inquiry do
  let(:inquiry) do
    Inquiry.create(
      title: 'Lorem Ipsum',
      name: 'John Doe',
      email: 'aibnbclone-dev+user1@bulbcorp.jp',
      body: 'Lorem ipsum dolor sit amet',
      status: :open,
    )
  end

  subject { inquiry }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :status }

  it 'belongs to user' do
    user = FactoryBot.create(:user)
    inquiry.user = user
    expect(inquiry.user).to eq user
  end
end
