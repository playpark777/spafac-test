namespace :reset_data do
  desc 'データをリセットする'
  task go: :environment do
    p '===== AdminUser ====='
    p 'AdminUserの削除'
    AdminUser.delete_all
    p 'AdminUserのIDリセット'
    AdminUser.reset_pk_sequence

    p '===== Auth ====='
    p 'Authの削除'
    Auth.delete_all
    p 'AuthのIDリセット'
    Auth.reset_pk_sequence

    p '===== BankAccountType ====='
    p 'BankAccountTypeの削除'
    BankAccountType.delete_all
    p 'BankAccountTypeのIDリセット'
    BankAccountType.reset_pk_sequence

    p '===== BankAccount ====='
    p 'BankAccountの削除'
    BankAccount.delete_all
    p 'BankAccountのIDリセット'
    BankAccount.reset_pk_sequence

    p '===== Bank ====='
    p 'Bankの削除'
    Bank.delete_all
    p 'BankのIDリセット'
    Bank.reset_pk_sequence

    p '===== BrowsingHistory ====='
    p 'BrowsingHistoryの削除'
    BrowsingHistory.delete_all
    p 'BrowsingHistoryのIDリセット'
    BrowsingHistory.reset_pk_sequence

    p '===== Emergency ====='
    p 'Emergencyの削除'
    Emergency.delete_all
    p 'EmergencyのIDリセット'
    Emergency.reset_pk_sequence

    p '===== IdentificationType ====='
    p 'IdentificationTypeの削除'
    IdentificationType.delete_all
    p 'IdentificationTypeのIDリセット'
    IdentificationType.reset_pk_sequence

    p '===== Identification ====='
    p 'Identificationの削除'
    Identification.delete_all
    p 'IdentificationのIDリセット'
    Identification.reset_pk_sequence

    p '===== Inquiry ====='
    p 'Inquiryの削除'
    Inquiry.delete_all
    p 'InquiryのIDリセット'
    Inquiry.reset_pk_sequence

    p '===== Wishlist ====='
    p 'Wishlistの削除'
    Wishlist.delete_all
    p 'WishlistのIDリセット'
    Wishlist.reset_pk_sequence

    p '===== UserNgevent ====='
    p 'UserNgeventの削除'
    UserNgevent.delete_all
    p 'UserNgeventのIDリセット'
    UserNgevent.reset_pk_sequence

    p '===== ReviewReply ====='
    p 'ReviewReplyの削除'
    ReviewReply.delete_all
    p 'ReviewReplyのIDリセット'
    ReviewReply.reset_pk_sequence

    p '===== Review ====='
    p 'Reviewの削除'
    Review.delete_all
    p 'ReviewのIDリセット'
    Review.reset_pk_sequence

    p '===== Reservation ====='
    p 'Reservationの削除'
    Reservation.delete_all
    p 'ReservationのIDリセット'
    Reservation.reset_pk_sequence

    p '===== ListingImage ====='
    p 'ListingImageの削除'
    ListingImage.delete_all
    p 'ListingImageのIDリセット'
    ListingImage.reset_pk_sequence

    p '===== ListingPv ====='
    p 'ListingPvの削除'
    ListingPv.delete_all
    p 'ListingPvのIDリセット'
    ListingPv.reset_pk_sequence

    p '===== Listing ====='
    p 'Listingの削除'
    Listing.delete_all
    p 'ListingのIDリセット'
    Listing.reset_pk_sequence

    p '===== MessageThreadUser ====='
    p 'MessageThreadUserの削除'
    MessageThreadUser.delete_all
    p 'MessageThreadUserのIDリセット'
    MessageThreadUser.reset_pk_sequence

    p '===== Message ====='
    p 'Messageの削除'
    Message.delete_all
    p 'MessageのIDリセット'
    Message.reset_pk_sequence

    p '===== MessageThread ====='
    p 'MessageThreadの削除'
    MessageThread.delete_all
    p 'MessageThreadのIDリセット'
    MessageThread.reset_pk_sequence

    p '===== ProfileImage ====='
    p 'ProfileImageの削除'
    ProfileImage.delete_all
    p 'ProfileImageのIDリセット'
    ProfileImage.reset_pk_sequence

    p '===== ProfileVideo ====='
    p 'ProfileVideoの削除'
    ProfileVideo.delete_all
    p 'ProfileVideoのIDリセット'
    ProfileVideo.reset_pk_sequence

    p '===== Profile ====='
    p 'Profileの削除'
    Profile.delete_all
    p 'ProfileのIDリセット'
    Profile.reset_pk_sequence

    p '===== User ====='
    p 'Userの削除'
    User.delete_all
    p 'UserのIDリセット'
    User.reset_pk_sequence

    p '===== 必要なデータの作成 ====='
    AdminUser.create(email: "admin@example.com", password: "password")
    exec "rake db:seed_fu FILTER=top_page_default_data,identification_type,bank"
  end
  desc 'データをリセットする'
  task reservation: :environment do
    p '===== Payment ====='
    p 'Paymentの削除'
    Payment.delete_all
    p 'PaymentのIDリセット'
    Payment.reset_pk_sequence

    p '===== UserNgevent ====='
    p 'UserNgeventの削除'
    UserNgevent.delete_all
    p 'UserNgeventのIDリセット'
    UserNgevent.reset_pk_sequence

    p '===== ReviewReply ====='
    p 'ReviewReplyの削除'
    ReviewReply.delete_all
    p 'ReviewReplyのIDリセット'
    ReviewReply.reset_pk_sequence

    p '===== Review ====='
    p 'Reviewの削除'
    Review.delete_all
    p 'ReviewのIDリセット'
    Review.reset_pk_sequence

    p '===== Reservation ====='
    p 'Reservationの削除'
    Reservation.delete_all
    p 'ReservationのIDリセット'
    Reservation.reset_pk_sequence

    p '===== MessageThreadUser ====='
    p 'MessageThreadUserの削除'
    MessageThreadUser.delete_all
    p 'MessageThreadUserのIDリセット'
    MessageThreadUser.reset_pk_sequence

    p '===== Message ====='
    p 'Messageの削除'
    Message.delete_all
    p 'MessageのIDリセット'
    Message.reset_pk_sequence

    p '===== MessageThread ====='
    p 'MessageThreadの削除'
    MessageThread.delete_all
    p 'MessageThreadのIDリセット'
    MessageThread.reset_pk_sequence
  end
end
