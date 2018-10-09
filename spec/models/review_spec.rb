require 'rails_helper'

describe Review do
  let(:review) { FactoryBot.create(:review) }

  subject { review }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :guest_id }
  it { is_expected.to validate_presence_of :host_id }
  it { is_expected.to validate_presence_of :reservation_id }
  it { is_expected.to validate_presence_of :listing_id }
  it { is_expected.to validate_presence_of :msg }
  it { is_expected.to validate_presence_of :accuracy }
  it { is_expected.to validate_presence_of :communication }
  it { is_expected.to validate_presence_of :cleanliness }
  it { is_expected.to validate_presence_of :location }
  it { is_expected.to validate_presence_of :check_in }
  it { is_expected.to validate_presence_of :cost_performance }
  it { is_expected.to validate_presence_of :total }

  it "belongs to listing" do
    listing = Listing.find(review.listing_id)
    expect(review.listing).to eq listing
  end

  it "belongs to reservation" do
    reservation = Reservation.find(review.reservation_id)
    expect(review.reservation).to eq reservation
  end

  it "has one review_reply" do
    expect(review).to have_one(:review_reply)
  end

  describe "#calc_ave_of_listing" do
    it "calculate average of listing" do
      expect(review.calc_ave_of_listing).to be true
    end
  end

  describe "#calc_ave_of_profile" do
    it "calculate average of profile" do
      expect(review.calc_ave_of_profile).to be true
    end
  end
end
