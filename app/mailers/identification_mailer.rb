class IdentificationMailer < ApplicationMailer
  def send_identification_is_approved_notification(identification)
    @locale = I18n.locale

    @identification = identification
    @to_user = @identification.user
    @email = EmailTemplate.find_by(email_type: 0)
    @signature = EmailTemplateSignature.first

    mail(
      to: @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end

  def send_identification_is_rejected_notification(identification)
    @locale = I18n.locale

    @identification = identification
    @to_user = @identification.user
    @email = EmailTemplate.find_by(email_type: 1)
    @signature = EmailTemplateSignature.first

    mail(
      to: @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end
end
