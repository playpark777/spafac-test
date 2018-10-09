class ReservationMailer < ApplicationMailer

  def send_new_reservation_notification(reservation)
    @locale = I18n.locale
    @from_user = User.find(reservation.guest_id)
    @to_user = User.find(reservation.host_id)
    @email = EmailTemplate.find_by(email_type: 3)
    @signature = EmailTemplateSignature.first

    mail(
      to: @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end

  def send_update_reservation_notification(reservation, from_user_id)
    @locale = I18n.locale

    if from_user_id == reservation.guest_id
      to_user_id = reservation.host_id
      @dest = "host"
    elsif from_user_id == reservation.host_id
      to_user_id = reservation.guest_id
      @dest = "guest"
    end

    @from_user = User.find(from_user_id)
    @to_user = User.find(to_user_id)
    @email = EmailTemplate.find_by(email_type: 4)
    @signature = EmailTemplateSignature.first

    mail(
      to:      @to_user.email,
      subject: reservation.subject_of_update_mail
    ) do |format|
      format.html
      format.text
    end
  end
end
