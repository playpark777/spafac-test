class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default from: "default-from-email@example.com"

  def send_confirmation_on_create_instructions(record, token, opts={})
    @resource = record
    @token = token
    @email = EmailTemplate.find_by(email_type: 8)
    @signature = EmailTemplateSignature.first

    mail(
      to: @resource.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html { render template: "users/mailer/confirmation_on_create_instructions" }
      format.text { render template: "users/mailer/confirmation_on_create_instructions" }
    end
  end

  def send_unlock_instructions(record, token, opts={})
    @resource = record
    @token = token
    @email = EmailTemplate.find_by(email_type: 9)
    @signature = EmailTemplateSignature.first

    mail(
      to: @resource.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html { render template: "users/mailer/unlock_instructions" }
      format.text { render template: "users/mailer/unlock_instructions" }
    end
  end

  def send_confirmation_instructions(record, token, opts={})
    @resource = record
    @token = token
    @email = EmailTemplate.find_by(email_type: 10)
    @signature = EmailTemplateSignature.first

    mail(
      to: @resource.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html { render template: "users/mailer/confirmation_instructions" }
      format.text { render template: "users/mailer/confirmation_instructions" }
    end
  end

  def send_reset_password_instructions(record, token, opts={})
    @resource = record
    @token = token
    @email = EmailTemplate.find_by(email_type: 11)
    @signature = EmailTemplateSignature.first

    mail(
      to: @resource.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html { render template: "users/mailer/reset_password_instructions" }
      format.text { render template: "users/mailer/reset_password_instructions" }
    end
  end
end
