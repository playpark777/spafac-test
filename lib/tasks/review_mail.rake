namespace :review_mail do
  desc 'send review mails'
  task send: :environment do
    reservations = Reservation.finished_before_yesterday.review_mail_never_be_sent
    reservations.each do |r|

      #ReviewMailer.send_review_notification(r).deliver_later!(wait: 1.minute) # if you want to use active job(delayedjob, resque....), use this line.
      ReviewMailer.send_review_notification(r).deliver_now! # if you don't want to use active job, use this line.

      # if you want to update info below one by one, remove comment-out
      # r.review_mail_sent_at = Time.zone.now
      # r.review_expiration_date = Time.zone.now + 14.days
      # r.save
    end

    # if you want to use update_all, use this below
    reservations.update_all(review_mail_sent_at: Time.zone.now, review_expiration_date: Time.zone.now + 14.days)

  end
end
