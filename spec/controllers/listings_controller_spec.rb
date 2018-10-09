require 'rails_helper'

describe ListingsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of listings created by current user to @listings' do
      current_user_listings = FactoryBot.create_list(:listing, 3, user: @user)
      get :index
      expect(assigns(:listings)).to match_array(current_user_listings)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested listing to @listing' do
      listing = FactoryBot.create(:listing)
      get :show, params: { id: listing.id }
      expect(assigns[:listing]).to eq listing
    end

    it 'renders the :show template' do
      listing = FactoryBot.create(:listing, user: @user)
      get :show, params: { id: listing.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new Listing to @listing' do
      get :new
      expect(assigns[:listing]).to be_a_new(Listing)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested listing to @listing' do
      listing = FactoryBot.create(:listing, user: @user)
      get :edit, params: { id: listing.id }
      expect(assigns[:listing]).to eq listing
    end

    it 'renders the :edit template' do
      listing = FactoryBot.create(:listing, user: @user)
      get :edit, params: { id: listing.id }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new listing to the database' do
        expect {
          post :create, params: { listing: FactoryBot.attributes_for(:listing, user: @user) }
        }.to change(Listing, :count).by(1)
      end

      it 'redirects to listings#show' do
        post :create, params: { listing: FactoryBot.attributes_for(:listing, user: @user) }
        expect(response).to redirect_to(
          manage_listing_listing_images_path(assigns[:listing]))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new listing in the database' do
        expect {
          post :create, params: { listing: FactoryBot.attributes_for(:invalid_listing, user: @user) }
        }.not_to change(Listing, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { listing: FactoryBot.attributes_for(:invalid_listing, user: @user) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      @listing = FactoryBot.create(:listing, user: @user)
    end

    context 'with valid attributes' do
      before do
        @updated_listing = @listing.attributes
        @updated_listing[:title] = "Updated"
        @updated_listing[:charter_type] = Listing.charter_types.invert[rand(0..(Listing.charter_types.count - 1))]
      end

      it 'locates the requested @listing' do
        patch :update, params: { id: @listing.id, listing: @updated_listing }
        @listing.reload
        expect(@listing).to eq (@listing)
      end

      it "changes @listing's attributes" do
        patch :update, params: { id: @listing.id, listing: @updated_listing }
        @listing.reload
        expect(@listing.title).to eq "Updated"
      end

      it 'redirects to the updated listing' do
        patch :update, params: { id: @listing.id, listing: @updated_listing }
        expect(request).to redirect_to manage_listing_listing_images_path(@listing)
      end
    end

    context 'with invalid attributes' do
      before do
        @updated_listing = @listing.attributes
        @updated_listing[:title] = ""
        @updated_listing[:charter_type] = Listing.charter_types.to_a.sample[0]
      end

      it "does not change the listing's attributes" do
        patch :update, params: {  id: @listing.id, listing: @updated_listing }
        @listing.reload
        expect(@listing.title).to eq @listing.title
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the listing from the database' do
      listing =  FactoryBot.create(:listing, user: @user)
      expect {
        delete :destroy, params: { id: listing.id }
      }.to change(Listing, :count).by(-1)
    end

    it 'redirects to listings#index' do
      listing =  FactoryBot.create(:listing, user: @user)
      delete :destroy, params: { id: listing.id }
      expect(response).to redirect_to listings_path
    end
  end

  describe 'GET #publish' do
    it 'makes the listing#open as true' do
      listing = FactoryBot.create(:listing, user: @user)
      get :publish, params: { listing_id: listing.id }
      expect(listing.reload.open).to be_truthy
    end

    it 'redirects to the listing' do
      listing = FactoryBot.create(:listing, user: @user)
      get :publish, params: { listing_id: listing.id }
      expect(response).to redirect_to listing_path(listing)
    end
  end

  describe 'GET #unpublish' do
    it 'makes the listing#open as false' do
      listing = FactoryBot.create(:opened_listing, user: @user)
      get :unpublish, params: { listing_id: listing.id }
      expect(listing.reload.open).not_to be_truthy
    end

    it 'redirects to edit the listing page' do
      listing = FactoryBot.create(:opened_listing, user: @user)
      get :unpublish, params: { listing_id: listing.id }
      expect(response).to redirect_to edit_listing_path(listing)
    end
  end

  describe 'GET #search' do
    before do
      @tomakomai_listings =
        FactoryBot.create_list(:opened_listing, 3, location: "北海道苫小牧市錦岡443")
      @tomakomai_listings_closed =
        FactoryBot.create_list(:listing, 2, location: "北海道苫小牧市錦岡443")
    end

    it 'populates an array of listings location includes "苫小牧市"' do
      get :search, params: { search: { location: '苫小牧市', num_of_guest: 1, where: "header" } }
      expect(assigns[:listings]).to match_array(@tomakomai_listings)
      expect(assigns[:listings].count).to eq @tomakomai_listings.count
    end

    it 'does not populates an array of closed listings' do
      get :search, params: { search: { location: '苫小牧市', num_of_guest: 1, where: "header" } }
      expect(assigns[:listings]).not_to include(@tomakomai_listings_closed)
    end

    it 'renders the :search template' do
      get :search, params: { search: { location: '苫小牧市', num_of_guest: 1, where: "header" } }
      expect(response).to render_template :search
    end
  end
end
