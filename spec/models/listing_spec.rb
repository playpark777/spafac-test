require 'rails_helper'

describe Listing do
  let(:listing) { FactoryBot.create(:listing) }

  subject { listing }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :charter_type }
  it { is_expected.to validate_presence_of :location }
  it { is_expected.to validate_presence_of :longitude }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :capacity }

  it "belongs to user" do
    user = User.find(listing.user_id)
    expect(listing.user).to eq user
  end

  it "has many listing images" do
    expect(listing).to have_many(:listing_images)
  end

  it "has many reservations" do
    expect(listing).to have_many(:reservations)
  end

  it "has many reviews" do
    expect(listing).to have_many(:reviews)
  end

  it "has many listing_ngevents" do
    expect(listing).to have_many(:listing_ngevents)
  end

  describe '#publish' do
    it 'makes an open attribute true' do
      listing.publish
      expect(listing.reload.open).to be_truthy
    end

    it 'returns true' do
      expect(listing.publish).to be_truthy
    end
  end

  describe '#unpublish' do
    before { listing.publish }
    it 'makes an open attribute false' do
      listing.unpublish
      expect(listing.reload.open).to be_falsy
    end

    it 'returns true' do
      expect(listing.unpublish).to be_truthy
    end
  end

  describe '#set_lon_lat' do
    before do
      # latitude: 42, longitude: 141
      listing.location = "北海道苫小牧市錦岡443"

      @api_status = listing.set_lon_lat
    end

    # it 'returns "OK"', unless: @api_status == "OVER_QUERY_LIMIT" do
    #   expect(listing.set_lon_lat).to eq "OK"
    # end
  end

  describe '#left_steps' do
    context 'when left step is nothing' do
      it 'returns a empty hash' do
        expect(listing.left_steps).to match({})
      end
    end

    context 'when a step has not finished yet' do
      before { listing.listing_images[0].destroy }
      it 'returns hash of left steps' do
        expect(listing.reload.left_steps).to match({ listing_image: true })
      end
    end
  end

  describe '#left_step_count' do
    context 'when left step is nothing' do
      it 'returns 0' do
        expect(listing.left_step_count).to eq 0
      end
    end

    context 'when a step has not finished yet' do
      before { listing.listing_images[0].destroy }
      it 'returns 1' do
        expect(listing.reload.left_step_count).to eq 1
      end
    end
  end

  describe '#has_completed?' do
    context 'when left step is nothing' do
      it 'returns true' do
        expect(listing.has_completed?).to be_truthy
      end
    end

    context 'when a step has not finished yet' do
      before { listing.listing_images[0].destroy }
      it 'returns false' do
        expect(listing.reload.has_completed?).to be_falsy
      end
    end
  end
end
