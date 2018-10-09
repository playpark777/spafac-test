class MessageMailer < ApplicationMailer

  def send_new_message_notification(message_thread, message_params)
    @locale = set_url_locale
    @message_thread = message_thread
    @email = EmailTemplate.find_by(email_type: 2)
    @signature = EmailTemplateSignature.first
    @from_user = User.find(message_params["from_user_id"])
    @to_user = User.find(message_params["to_user_id"])

    mail(
      to: @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end
end
