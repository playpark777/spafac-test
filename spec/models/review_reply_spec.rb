require 'rails_helper'

describe ReviewReply do
  let(:review_reply) { FactoryBot.create(:review_reply) }

  subject { review_reply }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :review_id }
  it { is_expected.to validate_presence_of :msg }

  it "belongs to review" do
    review = Review.find(review_reply.review_id)
    expect(review_reply.review).to eq review
  end
end
