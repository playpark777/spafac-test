ActiveAdmin.register EmailTemplate do

  permit_params :email_type, :subject, :html_body, :text_body

  filter :subject
  filter :html_body
  filter :text_body

  index do
    column :email_type_i18n
    column :subject
    column :html_body
    column :text_body

    actions
  end

  show title: :email_type_i18n do
    attributes_table do
      row :email_type_i18n
      row :subject
      row :html_body
      row :text_body
    end
  end

  form do |f|
    email_types = EmailTemplate.email_types.keys
    used_email_types = EmailTemplate.pluck(:email_type)
    unused_email_types = email_types - used_email_types

    if !f.object.new_record?
      unused_email_types.unshift(resource.email_type)
    end

    f.inputs do
      f.input :email_type, as: :select, collection: unused_email_types.map { |k| [EmailTemplate.email_types_i18n[k], k] }, prompt: true
      f.input :subject
      f.input :html_body
      f.input :text_body
    end

    f.actions
  end

# 身分証明書承認メールの送信
  member_action :send_identification_approved, method: :post do
    user = User.find(2)
    identification = user.profile.build_identification
    method_name = "send_identification_is_approved_notification"

    IdentificationMailer.send(method_name, identification).deliver_now!
  end

# 身分証明書拒否メールの送信
  member_action :send_identification_rejected, method: :post do
    user = User.find(2)
    identification = user.profile.build_identification
    method_name = "send_identification_is_rejected_notification"

    IdentificationMailer.send(method_name, identification).deliver_now!
  end

# 新規メッセージ通知メールの送信
  member_action :send_new_message_approved, method: :post do
    from_user = User.find(1)
    to_user = User.find(2)

    message_thread = MessageThread.new(id: 0)
    message_params = {
      "message_thread_id": message_thread.id,
      "from_user_id": from_user.id,
      "to_user_id": to_user.id,
      "content": "メッセージが入ります。",
      "read": false,
    }.with_indifferent_access

    MessageMailer.send_new_message_notification(message_thread, message_params).deliver_now!
  end

# 新規予約通知メールの送信
  member_action :send_new_reservation_approved, method: :post do
    from_user = User.find(1)
    to_user = User.find(2)

    reservation = Reservation.new(
      host_id: to_user.id,
      guest_id: from_user.id,
      listing_id: to_user.listings.first,
      msg: "",
      progress: :requested
    )

    ReservationMailer.send_new_reservation_notification(reservation).deliver_now!
  end

# 予約状態の変更通知メール
  member_action :send_update_reservation_notification, method: :post do
    from_user = User.find(1)
    to_user = User.find(2)

    reservation = Reservation.new(
      host_id: to_user.id,
      guest_id: from_user.id,
      listing_id: to_user.listings.first,
      msg: "",
      progress: :canceled,
    )

    ReservationMailer.send_update_reservation_notification(reservation, reservation.guest_id).deliver_now!
  end

# レビューの新規お知らせメールの送信
  member_action :send_review_notification, method: :post do
    host_user = User.find(1)
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.find(2)
    reservation = Reservation.create(
      host_id: listing.user.id,
      guest_id: guest_user.id,
      listing_id: listing.id,
      num_of_people: 4,
      msg: "",
      progress: :rejected,
      checkin: Date.today,
      checkout: Date.today + 3.days,
    )

    ReviewMailer.send_review_notification(reservation).deliver_now!
    reservation.destroy
    listing.destroy
  end

# レビュー公開通知メールの送信
  member_action :send_review_opened_notification, method: :post do
    host_user = User.find(1)
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.find(2)
    reservation = Reservation.create(
      host_id: listing.user.id,
      guest_id: guest_user.id,
      listing_id: listing.id,
      num_of_people: 4,
      msg: "",
      progress: :rejected,
      checkin: Date.today,
      checkout: Date.today + 3.days,
    )

    ReviewMailer.send_review_opened_notification(reservation).deliver_now!
    reservation.destroy
    listing.destroy
  end

# レビュー返信通知メールの送信
  member_action :send_review_reply_notification, method: :post do
    host_user = User.find(1)
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.find(2)

    reservation = Reservation.create(
      host_id: listing.user.id,
      guest_id: guest_user.id,
      listing_id: listing.id,
      num_of_people: 4,
      msg: "",
      progress: :rejected,
      checkin: Date.today,
      checkout: Date.today + 3.days,
    )

    review = Review.create(
      host_id: listing.user.id,
      guest_id: guest_user.id,
      reservation_id: reservation.id,
      listing_id: listing.id,
      total: 4,
      msg: "最高でした。"
    )

    ReviewMailer.send_review_reply_notification(reservation, review).deliver_now!
    review.destroy
    reservation.destroy
    listing.destroy
  end

  member_action :send_confirmation_on_create_instructions, method: :post do
    record = User.new(id: 0, email: current_admin_user.email, created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_confirmation_on_create_instructions(record, token, opts={}).deliver_now!
  end

  member_action :send_unlock_instructions, method: :post do
    record = User.new(id: 0, email: current_admin_user.email, created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_unlock_instructions(record, token, opts={}).deliver_now!
  end

  member_action :send_confirmation_instructions, method: :post do
    record = User.new(id: 0, email: current_admin_user.email, created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_confirmation_instructions(record, token, opts={}).deliver_now!
  end

  member_action :send_reset_password_instructions, method: :post do
    record = User.new(id: 0, email: current_admin_user.email, created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_reset_password_instructions(record, token, opts={}).deliver_now!
  end

  action_item :view, only: :show do
    #email_typeのprimary keyをemail_type属性にしている
    email_type = params[:id]
    text = I18n.t("dashboard.email_template.button")

    if email_type == "identification_is_approved_notification"
      link_to(text, send_identification_approved_admin_email_template_path(email_type), method: :post )
    elsif email_type == "identification_is_rejected_notification"
      link_to(text, send_identification_rejected_admin_email_template_path(email_type), method: :post )
    elsif email_type == "new_message_notification"
      link_to(text, send_new_message_approved_admin_email_template_path(email_type), method: :post )
    elsif email_type == "new_reservation_notification"
      link_to(text, send_new_reservation_approved_admin_email_template_path(email_type), method: :post )
    elsif email_type == "update_reservation_notification"
      link_to(text, send_update_reservation_notification_admin_email_template_path(email_type), method: :post )
    elsif email_type == "send_review_notification"
      link_to(text, send_review_notification_admin_email_template_path(email_type), method: :post )
    elsif email_type == "review_opened_notification"
      link_to(text, send_review_opened_notification_admin_email_template_path(email_type), method: :post )
    elsif email_type == "review_reply_notification"
      link_to(text, send_review_reply_notification_admin_email_template_path(email_type), method: :post )
    elsif email_type == "confirmation_on_create_instructions"
      link_to(text, send_confirmation_on_create_instructions_admin_email_template_path(email_type), method: :post )
    elsif email_type == "unlock_instructions"
      link_to(text, send_unlock_instructions_admin_email_template_path(email_type), method: :post )
    elsif email_type == "confirmation_instructions"
      link_to(text, send_confirmation_instructions_admin_email_template_path(email_type), method: :post )
    elsif email_type == "reset_password_instructions"
      link_to(text, send_reset_password_instructions_admin_email_template_path(email_type), method: :post )
    end
  end
end
