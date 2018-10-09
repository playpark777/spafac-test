require 'rails_helper'

describe IdentificationsController do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET #show" do
    it "assigns the requested identification to @identification" do
      identification = Identification.find_by(profile: @user.profile)
      get :show, params: { id: identification }
      expect(assigns(:identification)).to eq identification
    end

    it "renders the :show template" do
      identification = Identification.find_by(profile: @user.profile)
      get :show, params: { id: identification }
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { @user.profile.identification.destroy! }
    it "assigns a new Identification to @identification" do
      get :new
      expect(assigns(:identification)).to be_a_new(Identification)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before { @user.profile.identification.destroy! }
    context "with valid attributes" do
      it "saves the new identification to the database" do
        expect {
          post :create, params: { identification: FactoryBot.attributes_for(:identification) }
        }.to change(Identification, :count).by(1)
      end

      it "redirects to identifications#edit" do
        post :create, params: { identification: FactoryBot.attributes_for(:identification) }
        expect(response).to redirect_to profile_identification_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new identification in the database" do
        expect {
          post :create, params: { identification: FactoryBot.attributes_for(:invalid_identification) }
        }.not_to change(Identification, :count)
      end

      it "re-renders the :new template" do
        post :create, params: {  identification: FactoryBot.attributes_for(:invalid_identification) }
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the identification from the database" do
      expect {
        delete :destroy, params: { id: @user.identification }
      }.to  change(Identification, :count).by(-1)
    end

    it "redirects to identifications#show" do
      delete :destroy, params: { id: @user.identification }
      expect(response).to redirect_to new_profile_identification_path
    end
  end
end
