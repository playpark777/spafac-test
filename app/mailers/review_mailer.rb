class ReviewMailer < ApplicationMailer

  def send_review_notification(reservation)
    @locale = set_url_locale
    @reservation = reservation
    @listing = reservation.listing
    @to_user = User.find(reservation.guest_id)
    @host_user = User.find(reservation.host_id)
    @email = EmailTemplate.find_by(email_type: 5)
    @signature = EmailTemplateSignature.first

    mail(
      to:      @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end

  def send_review_reply_notification(reservation, review)
    @locale = set_url_locale
    @reservation = reservation
    @review = review
    @listing = reservation.listing
    @to_user = User.find(reservation.host_id)
    @guest_user = User.find(reservation.guest_id)
    @email = EmailTemplate.find_by(email_type: 7)
    @signature = EmailTemplateSignature.first

    mail(
      to:      @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end

  def send_review_opened_notification(reservation)
    @locale = set_url_locale
    @reservation = reservation
    @listing = reservation.listing
    @to_user = reservation.guest
    @host_user = reservation.host
    @email = EmailTemplate.find_by(email_type: 6)
    @signature = EmailTemplateSignature.first

    mail(
      to:      @to_user.email,
      subject: ERB.new(@email.subject).result(binding)
    ) do |format|
      format.html
      format.text
    end
  end
end
