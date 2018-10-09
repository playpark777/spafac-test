class Users::OmniauthController < ApplicationController
  def localized
    session[:omniauth_login_locale] = I18n.locale
    puts params[:provider].inspect
    if params[:provider] == 'facebook'
      redirect_to user_facebook_omniauth_authorize_path
    end
  end
end
