require 'rails_helper'

RSpec.describe ProfileImagesController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
    @listing = FactoryBot.create(:listing)
  end
  describe 'GET #edit' do
    context 'without params[:listing_id]' do
      it "assigns the current user's profile_image" do
        get :edit
        expect(assigns[:profile_image].user).to eq @user
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
      it "assigns the current user's profile_image" do
        get :edit, params: { listing_id: @listing.id }
        expect(assigns[:profile_image].user).to eq @user
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
        it "locates the current user's profile image" do
          patch :update, params: { profile_image: FactoryBot.attributes_for(:profile_image, user: @user, profile: @user.profile), listing_id: @listing.id }
          expect(assigns[:profile_image].user).to eq @user
        end

        it "changes @profile_image's attributes" do
          patch :update, params: { profile_image: FactoryBot.attributes_for(:profile_image, user_id: @user.id, profile_id: @user.profile.id, caption: 'test caption'), listing_id: @listing.id }
          @user.reload
          expect(assigns[:profile].profile_image.caption).to eq @user.profile_image.caption
        end

        # it 'redirects to the requested listing page'
      end

      context 'without params[:listing_id]' do
        it "locates the current user's profile image" do
          patch :update, params: { profile_image: FactoryBot.attributes_for(:profile_image, user: @user, profile: @user.profile) }
          expect(assigns[:profile_image].user).to eq @user
        end

        it "changes @profile_image's attributes" do
          patch :update, params: { profile_image: FactoryBot.attributes_for(:profile_image, user_id: @user.id, profile_id: @user.profile.id, caption: 'test caption') }
          @user.reload
          expect(assigns[:profile].profile_image.caption).to eq @user.profile_image.caption
        end

        it "redirects to the current user's profile page" do
          patch :update, params: { profile_image: FactoryBot.attributes_for(:profile_image, user: @user, profile: @user.profile) }
          expect(response).to redirect_to profile_path(@user.profile)
        end
      end
    end
  end
  context 'with invalid attributes cation if there is a need' do
    # it "does not change @profile_image's attributes"
    # it 're-renders :edit template'
  end
end
