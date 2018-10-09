class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
    if current_user
      @inquiry.name = current_user.profile.full_name
      @inquiry.email = current_user.email
    end
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    @inquiry.user_agent = request.env["HTTP_USER_AGENT"]
    if @inquiry.valid?
      render action: :confirm
    else
      flash[:alert] = I18n.t('alerts.inquiry.save.failure',
                              model: Inquiry.model_name.human)
      flash.now[:messages] = @inquiry.errors.full_messages
      render action: :new
    end
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user = current_user if user_signed_in?
    @inquiry.remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    @inquiry.user_agent = request.env["HTTP_USER_AGENT"]

    if @inquiry.save
      flash[:notice] = I18n.t('alerts.inquiry.save.success',
                              model: Inquiry.model_name.human)
      redirect_to root_url
    else
      flash[:alert] = I18n.t('alerts.inquiry.save.failure',
                              model: Inquiry.model_name.human)
      flash.now[:messages] = @inquiry.errors.full_messages
      render :new
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(
      :title,
      :name,
      :email,
      :body
    )
  end
end
