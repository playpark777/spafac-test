class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  def confirmation_on_create_instructions(record, token, opts={})
    DeviseMailer.send_confirmation_on_create_instructions(record, token, opts).deliver_now!
  end

  def unlock_instructions(record, token, opts={})
    DeviseMailer.send_unlock_instructions(record, token, opts).deliver_now!
  end

  def confirmation_instructions(record, token, opts={})
    DeviseMailer.send_confirmation_instructions(record, token, opts).deliver_now!
  end

  def reset_password_instructions(record, token, opts={})
    DeviseMailer.send_reset_password_instructions(record, token, opts).deliver_now!
  end
end
