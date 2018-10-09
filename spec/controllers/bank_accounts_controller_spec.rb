require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  before :each do
    Bank.create(name: '三井住友銀行', code: '0009', available: true)
    BankAccountType.create(name: '普通', available: true)

    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'GET #show' do
    before { FactoryBot.create(:bank_account, profile: @user.profile) }
    it "assigns the current_user's bank_account to @bank_account" do
      bank_account = BankAccount.find_by(profile: @user.profile)
      get :show
      expect(assigns(:bank_account)).to eq bank_account
    end

    it 'renders the :show template' do
      get :show
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new BankAccount to @bank_account' do
      get :new
      expect(assigns(:bank_account)).to be_a_new(BankAccount)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new bank account to the database' do
        expect {
          post :create, params: { bank_account: FactoryBot.attributes_for(:bank_account, profile: @user.profile) }
        }.to change(BankAccount, :count).by(1)
      end

      it 'redirects to bank_accounts#show' do
        post :create, params: { bank_account: FactoryBot.attributes_for(:bank_account, profile: @user.profile) }
        expect(response).to redirect_to profile_bank_account_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new bank account in the database' do
        expect {
          post :create, params: { bank_account: FactoryBot.attributes_for(:invalid_bank_account, profile: @user.profile) }
        }.not_to change(BankAccount, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { bank_account: FactoryBot.attributes_for(:invalid_bank_account, profile: @user.profile) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before { FactoryBot.create(:bank_account, profile: @user.profile) }
    it 'deletes the bank account from the database' do
      expect {
        delete :destroy
      }.to change(BankAccount, :count).by(-1)
    end

    it 'redirects to bank_accounts#new' do
      delete :destroy
      expect(response).to redirect_to new_profile_bank_account_path
    end
  end
end
