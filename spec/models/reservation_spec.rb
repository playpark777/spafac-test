require 'rails_helper'

describe Reservation do
  let(:reservation) { FactoryBot.create(:reservation) }

  subject { reservation }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :host_id }
  it { is_expected.to validate_presence_of :guest_id }
  it { is_expected.to validate_presence_of :listing_id }
  it { is_expected.to validate_presence_of :num_of_people }
  it { is_expected.to validate_presence_of :progress }
  it { is_expected.to validate_presence_of :checkin }
  it { is_expected.to validate_presence_of :checkout }

  it "belongs to host" do
    host = User.find(reservation.host_id)
    expect(reservation.host).to eq host
  end

  it "belongs to guest" do
    guest = User.find(reservation.guest_id)
    expect(reservation.guest).to eq guest
  end

  it "belongs to listing" do
    listing = Listing.find(reservation.listing_id)
    expect(reservation.listing).to eq listing
  end

  it "has one review" do
    expect(reservation).to have_one(:review)
  end

  it "has one ngevent" do
    expect(reservation).to have_one(:ngevent)
  end
end
