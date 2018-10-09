require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET #edit' do
    it 'returns :ok in response' do
      get :edit
      expect(response.status).to eq(200)
    end
    it "renders the :edit template" do
      get :edit
      expect(response).to render_template :edit
    end
  end
end
