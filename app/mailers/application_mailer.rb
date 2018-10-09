class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.from.default

  def set_url_locale
    I18n.locale == I18n.default_locale ? nil : I18n.locale
  end
end
