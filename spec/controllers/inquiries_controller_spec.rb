require 'rails_helper'

describe InquiriesController do
  shared_examples_for 'basic inquiry functions' do
    describe 'GET #new' do
      it 'assigns a new Inquiry to @inquiry' do
        get :new
        expect(assigns(:inquiry)).to be_a_new(Inquiry)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #confirm' do
      context 'with valid attributes' do
        it 'renders the :confirm template' do
          post :confirm, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          expect(response).to render_template :confirm
        end
      end

      context 'with invalid attributes' do
        it 're-renders the :new template' do
          post :confirm, params: { inquiry: FactoryBot.attributes_for(:invalid_inquiry) }
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'user access' do
    before :each do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    it_behaves_like 'basic inquiry functions'

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new inquiry to the database' do
          expect {
            post :create, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          }.to change(Inquiry, :count).by(1)
        end

        it 'saves user who sent the inquiry' do
          post :create, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          expect(assigns[:inquiry].user).to be controller.current_user
        end

        it 'redirects to root' do
          post :create, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          expect(response).to redirect_to root_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new inquiry in the database' do
          expect {
            post :create, params: { inquiry: FactoryBot.attributes_for(:invalid_inquiry) }
          }.not_to change(Inquiry, :count)
        end

        it 're-renders the :new template' do
          post :create, params: { inquiry: FactoryBot.attributes_for(:invalid_inquiry) }
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'guest access' do
    it_behaves_like 'basic inquiry functions'

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new inquiry to the database' do
          expect {
            post :create, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          }.to change(Inquiry, :count).by(1)
        end

        it 'redirects to root' do
          post :create, params: { inquiry: FactoryBot.attributes_for(:inquiry) }
          expect(response).to redirect_to root_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new inquiry in the database' do
          expect {
            post :create, params: { inquiry: FactoryBot.attributes_for(:invalid_inquiry) }
          }.not_to change(Inquiry, :count)
        end

        it 're-renders the :new template' do
          post :create, params: { inquiry: FactoryBot.attributes_for(:invalid_inquiry) }
          expect(response).to render_template :new
        end
      end
    end
  end
end
