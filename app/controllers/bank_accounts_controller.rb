class BankAccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.profile.bank_account.present?
      @bank_account = current_user.profile.bank_account
    else
      redirect_to action: :new
    end
  end

  def new
    if current_user.profile.bank_account.present?
      redirect_to action: :show
    else
      @bank_account = current_user.profile.build_bank_account
      @banks = Bank.availables
    end
  end

  def create
    @bank_account = current_user.profile.build_bank_account(
      bank_account_params
    )

    respond_to do |format|
      if @bank_account.save
        flash[:notice] = I18n.t('alerts.bank_account.save.success',
                                model: BankAccount.model_name.human)
        format.html { redirect_to action: :show }
        format.json { head :created, location: profile_bank_account_path }
      else
        flash[:alert] = I18n.t('alerts.bank_account.save.failure',
                               model: BankAccount.model_name.human)
        flash.now[:messages] = @bank_account.errors.full_messages
        format.html { render :new, notice: @bank_account.errors.full_messages.join('<br>') }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bank_account = current_user.profile.bank_account
    @bank_account.destroy
    flash[:notice] = I18n.t('alerts.bank_account.delete.success',
                            model: BankAccount.model_name.human)
    redirect_to action: :new
  end

  private
  def bank_account_params
    params.require(:bank_account).permit(
      :bank_id,
      :branch_code,
      :branch_name,
      :type_of_bank_account_id,
      :number,
      :name
    )
  end
end
