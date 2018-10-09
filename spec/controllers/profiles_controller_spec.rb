require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
    @listing = FactoryBot.create(:listing)
  end

  describe 'GET #edit' do
    context 'without params[:listing_id]' do
      it "assigns the current user's profile" do
        get :edit
        expect(assigns[:profile].user).to eq @user
      end
      it 'returns :ok in response' do
        get :edit
        expect(response.status).to eq (200)
      end
      it 'renders the :edit template' do
        get :edit
        expect(response).to render_template :edit
      end
    end
    context 'with params[:listing_id]' do
      it "assigns the current user's profile" do
        get :edit, params: { listing_id: @listing.id }
        expect(assigns[:profile].user).to eq @user
      end
      it 'returns :ok in response' do
        get :edit, params: { listing_id: @listing.id }
        expect(response.status).to eq (200)
      end
      it 'renders the :edit template' do
        get :edit, params: { listing_id: @listing.id }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      context 'with params[:listing_id]' do
        it "locates the current user's profile" do
          patch :update, params: { profile: FactoryBot.attributes_for(:profile, user: @user, gender: 'male'), listing_id: @listing.id }
          expect(assigns[:profile].user).to eq @user
        end

        it "changes @profile's attributes" do
          patch :update, params: { profile: FactoryBot.attributes_for(:profile, user: @user, gender: 'others'), listing_id: @listing.id }
          @user.reload
          expect(assigns[:profile].gender).to eq @user.profile.gender
        end

        # it 'redirects to the requested listing page'
      end

      context 'without params[:listing_id]' do
        it "locates the current user's profile" do
          patch :update, params: { profile: FactoryBot.attributes_for(:profile, user: @user, gender: 'male') }
          expect(assigns[:profile].user).to eq @user
        end

        it "changes @profile's attributes" do
          patch :update, params: { profile: FactoryBot.attributes_for(:profile, user: @user, gender: 'others') }
          @user.reload
          expect(assigns[:profile].gender).to eq @user.profile.gender
        end

        it "redirects to the current user's profile page" do
          patch :update, params: { profile: FactoryBot.attributes_for(:profile, user: @user, gender: 'male') }
          expect(response).to redirect_to profile_path(@user.profile)
        end
      end
    end

    context 'with invalid attributes cation if there is a need' do
      # it "does not change @profile's attributes"
      # it 're-renders :edit template'
    end
  end
end
