class BankBrancheController < ApplicationController
  before_action :authenticate_user!

    # GET /bank_branch/search/search.json
  def search
    @BankBranches = nil
    if params[:branch_code].present? && params[:bank_code].present?
      @BankBranches = BankBranche.find_by(bank_code: params[:bank_code], branch_code: params[:branch_code])
    elsif params[:branch_name].present? && params[:bank_code].present?
      @BankBranches = BankBranche.find_by(bank_code: params[:bank_code], branch_name: params[:branch_name])
    end
    render :json => @BankBranches
  end

  def autocomplete_bank_branch
    bank_branch_suggestions = BankBranche.autocomplete(params[:term]).pluck(:branch_name)
    respond_to do |format|
      format.html
      format.json {
        render json: bank_branch_suggestions
      }
    end
  end
end
