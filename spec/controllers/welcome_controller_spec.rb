require 'rails_helper'

describe WelcomeController do
  describe 'GET index' do
    # need view spec
    context 'basic' do
      it 'return :ok in response' do
        get :index
        expect(response.status).to eq(200)
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
      it "assigns @top_page_cover_images" do
        top_page_cover_image = FactoryBot.create(:top_page_cover_image)
        get :index
        expect(assigns(:top_page_cover_images)).to eq [top_page_cover_image]
      end
      it "assigns @top_page_cover_tagline" do
        top_page_cover_tagline = FactoryBot.create(:top_page_cover_tagline)
        get :index
        expect(assigns(:top_page_cover_tagline)).to eq top_page_cover_tagline
      end
      it "assigns @top_page_discovery_images" do
        top_page_discovery_image = FactoryBot.create(:top_page_discovery_image)
        get :index
        expect(assigns(:top_page_discovery_images)).to eq [top_page_discovery_image]
      end
      it "assigns @top_page_belt_image" do
        top_page_belt_image = FactoryBot.create(:top_page_belt_image)
        get :index
        expect(assigns(:top_page_belt_image)).to eq top_page_belt_image
      end
    end
  end
end
