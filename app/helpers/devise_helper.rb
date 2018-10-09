module DeviseHelper
  def devise_error_messages!(mode=nil)
    device_notification(resource.errors.empty?, mode)
    flash.now[:messages] = resource.errors.full_messages if flash.now[:messages].blank?
    flash.now[:messages] = flash[:messages] if flash[:messages].present?
  end
  def devise_edit_is_email?(mode)
    mode.present? && mode == "email"
  end
  def devise_edit_is_password?(mode)
    mode.present? && mode == "password"
  end

  private
  def device_notification(error_flag, mode)
    if !error_flag
      flash[:alert] =
      case controller.controller_name
      when "registrations"
        I18n.t('.errors.messages.not_saved', count: resource.errors.size,
                       resource: ".activerecord.attributes.user.#{mode}") if mode
        I18n.t('.devise.failure.invalid') if mode.nil?
      when "passwords", "confirmations"
        I18n.t('.errors.messages.not_completed', count: resource.errors.size)
      else
        nil
      end
    else
      flash[:success] = I18n.t('registrations.user.updated')
    end
  end
end
