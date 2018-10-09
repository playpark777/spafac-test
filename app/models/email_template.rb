class EmailTemplate < ApplicationRecord

  validates :email_type, presence: true, uniqueness: true
  validates :subject, presence: true
  validates :html_body, presence: true
  validates :text_body, presence: true

  enum email_type: {
    identification_is_approved_notification: 0,
    identification_is_rejected_notification: 1,
    new_message_notification: 2,
    new_reservation_notification: 3,
    update_reservation_notification: 4,
    send_review_notification: 5,
    review_opened_notification: 6,
    review_reply_notification: 7,
    confirmation_on_create_instructions: 8,
    unlock_instructions: 9,
    confirmation_instructions: 10,
    reset_password_instructions: 11
  }
end
