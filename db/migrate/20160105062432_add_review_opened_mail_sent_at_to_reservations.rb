class AddReviewOpenedMailSentAtToReservations < ActiveRecord::Migration[4.2]
  def change
    add_column :reservations, :review_opened_mail_sent_at, :datetime
  end
end
