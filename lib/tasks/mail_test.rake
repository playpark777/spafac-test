# メール確認用

# 身分証メール
# 承認
# rake mail_test:send_identification_approved
# 拒否
# rake mail_test:send_identification_rejected

# 新規メッセージ通知メール
# rake mail_test:send_new_message_notification

# 新規予約リクエストの通知メール
# rake mail_test:send_new_reservation_notification

# 予約状態の更新通知メール
# rake mail_test:send_update_reservation_notification

# レビュー新規お知らせメール
# rake mail_test:send_review_notification

# レビュー公開通知メール
# rake mail_test:send_review_opened_notification

# レビュー返信通知メール
# rake mail_test:send_review_reply_notification

namespace :mail_test do
  ## 身分証メール
  #承認完了
  task send_identification_approved: :environment do
    user = User.find(1)
    profile = Profile.find_by(user_id: user.id)
    identification = Identification.new(profile_id: profile.id)
    method_name = "send_identification_is_approved_notification"

    IdentificationMailer.send(method_name, identification).deliver_now!
  end
  #拒否
  task send_identification_rejected: :environment do
    user = User.find(1)
    profile = Profile.find_by(user_id: user.id)
    identification = Identification.new(profile_id: profile.id)
    method_name = "send_identification_is_rejected_notification"

    IdentificationMailer.send(method_name, identification).deliver_now!
  end
  ## 新規メッセージ通知メール
  task send_new_message_notification: :environment do
    from_user = User.find(1)
    to_user = User.find(2)

    message_thread = MessageThread.find_or_create_by(id: 1)
    message_params = {
      "message_thread_id": message_thread.id,
      "from_user_id": from_user.id,
      "to_user_id": to_user.id,
      "content": "メッセージが入ります。",
      "read": false,
    }.with_indifferent_access

    MessageMailer.send_new_message_notification(message_thread, message_params).deliver_now!
    message_thread.destroy
  end
  ## 新規予約リクエストの通知メール
  task send_new_reservation_notification: :environment do
    from_user = User.find(1)
    to_user = User.find(2)
    reservation = Reservation.new(
      host_id: to_user.id,
      guest_id: from_user.id,
      listing_id: to_user.listings.first,
      msg: "",
      progress: :requested
    )
    #progress: { requested: 0, canceled: 1, holded: 2, accepted: 3, rejected: 4, listing_closed: 5 }
    ReservationMailer.send_new_reservation_notification(reservation).deliver_now!
  end
  ## 予約状態の変更通知メール
  task send_update_reservation_notification: :environment do
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
  ## レビュー新規お知らせメール
  task send_review_notification: :environment do
    host_user = User.find(1) #user
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.find(2)

    reservation = if Reservation.exists?(id:1)
      Reservation.find(1)
    else
      reservation = Reservation.new(
        host_id: listing.user.id,
        guest_id: guest_user.id,
        listing_id: listing.id,
        num_of_people: 4,
        msg: "",
        progress: :rejected,
        checkin: Date.today,
        checkout: Date.today + 3.days,
      )
      reservation.save
      reservation
    end

    ReviewMailer.send_review_notification(reservation).deliver_now!
    reservation.destroy
    listing.destroy
  end
  ## レビュー公開通知メール
  task send_review_opened_notification: :environment do
    host_user = User.first
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.second

    @reservation = if Reservation.exists?(id:1)
      Reservation.find(1)
    else
      reservation = Reservation.new(
        host_id: listing.user.id,
        guest_id: guest_user.id,
        listing_id: listing.id,
        num_of_people: 4,
        msg: "",
        progress: :rejected,
        checkin: Date.today,
        checkout: Date.today + 3.days,
      )
      reservation.save
      reservation
    end

    ReviewMailer.send_review_opened_notification(@reservation).deliver_now!
    reservation.destroy
    listing.destroy
  end

  ## レビュー返信通知メール
  task send_review_reply_notification: :environment do
    host_user = User.first
    listing = host_user.listings.create(charter_type: 1, title: "タイトル", location: "渋谷", price: 5000)
    guest_user = User.second

    reservation = if Reservation.exists?(id:1)
      Reservation.find(1)
    else
      reservation = Reservation.new(
        host_id: listing.user.id,
        guest_id: guest_user.id,
        listing_id: listing.id,
        num_of_people: 4,
        msg: "",
        progress: :rejected,
        checkin: Date.today,
        checkout: Date.today + 3.days,
      )
      reservation.save
      reservation
    end
    review = if Review.exists?(reservation_id: reservation.id)
      Review.find(reservation.id)
    else
      review = Review.new(
        host_id: listing.user.id,
        guest_id: guest_user.id,
        reservation_id: reservation.id,
        listing_id: listing.id,
        total: 4,
        msg: "最高でした。"
      )
      review.save
      review
    end
    ReviewMailer.send_review_reply_notification(reservation, review).deliver_now!
    review.destroy
    reservation.destroy
    listing.destroy
  end

  #ユーザー登録メール
  task send_confirmation_on_create_instructions: :environment do
    record = User.new(id: 0, email: "sample@gmail.com", created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_confirmation_on_create_instructions(record, token, opts={}).deliver_now!
  end

  #アカウント凍結解除メール
  task send_unlock_instructions: :environment do
    record = User.new(id: 0, email: "sample@gmail.com", created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_unlock_instructions(record, token, opts={}).deliver_now!
  end

  #メールアドレス変更通知メール
  task send_confirmation_instructions: :environment do
    record = User.new(id: 0, email: "sample@gmail.com", created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_confirmation_instructions(record, token, opts={}).deliver_now!
  end

  #パスワードリセットメール
  task send_reset_password_instructions: :environment do
    record = User.new(id: 0, email: "sample@gmail.com", created_at: DateTime.now, updated_at: DateTime.now, uid: SecureRandom.hex(36), provider: "", username: nil)
    token = SecureRandom.hex(20)

    DeviseMailer.send_reset_password_instructions(record, token, opts={}).deliver_now!
  end
end
