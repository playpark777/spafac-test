require "csv"

image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic001.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 1
  obj.image = File.new(image_path)
  obj.order_num = 1
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic002.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 2
  obj.image = File.new(image_path)
  obj.order_num = 2
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic003.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 3
  obj.image = File.new(image_path)
  obj.order_num = 3
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic004.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 4
  obj.image = File.new(image_path)
  obj.order_num = 4
end

TopPageCoverTagline.seed do |obj|
  obj.id = 1
  obj.tagline_ja = "扉の向こうは新しい世界"
  obj.sub_tagline_ja = "旅はもっと楽しくなる"
  obj.tagline_en = "Open the door to a whole new experience"
  obj.sub_tagline_en = "Find a unique room for your next trip to Japan"
#    obj.tagline_zh_cn = "住在当地的旅行"
#    obj.sub_tagline_zh_cn = "象当地人一样生活"
end

image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic005.jpg")
TopPageDiscoveryImage.seed do |obj|
  obj.id = 1
  obj.order_num = 1
  obj.image = File.new(image_path)
  obj.tagline_ja = "東京"
  obj.tagline_en = "Tokyo"
#  obj.tagline_zh_cn = "东京"
  obj.link_url = "http://www.metro.tokyo.jp/index.htm"
  obj.size = 2
  obj.show_price = false
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic006.jpg")
TopPageDiscoveryImage.seed do |obj|
  obj.id = 2
  obj.order_num = 2
  obj.image = File.new(image_path)
  obj.tagline_ja = "大阪"
  obj.tagline_en = "Osaka"
#  obj.tagline_zh_cn = "大阪"
  obj.link_url = "http://www.google.com"
  obj.size = 1
  obj.show_price = false
end

image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic008.jpg")
TopPageBeltImage.seed do |obj|
  obj.id = 1
  obj.image_flg = true
  obj.image = File.new(image_path)
  obj.tagline_ja = "帯画像タグライン"
  obj.sub_tagline_ja = "帯画像サブタグライン"
  obj.tagline_en = "Belt Image Tagline"
  obj.sub_tagline_en = "Belt Image Sub Tagline"
#    obj.tagline_zh_cn = "住在当地的旅行"
#    obj.sub_tagline_zh_cn = "象当地人一样生活"
  obj.link_url = "http://www.travel-labo.com"
end

# ーーーーーーーーend top_page_default_dataーーーーーーーー#

id_types = %w(運転免許証 国民健康保険証 パスポート 住基カード マイナンバーカード)
id_types.each { |type| IdentificationType.create(name: type, available: true) }

# ーーーーーーーーend identification_dataーーーーーーーー#

banks = CSV.read('./db/fixtures/bank_list.csv').map { |row| {code: row[0], name: row[1]} }
banks.each { |bank| Bank.create(code: bank[:code], name: bank[:name]) }

# ーーーーーーーーend bankーーーーーーーー#

bank_account_types = %w(普通 当座)
bank_account_types.each { |type| BankAccountType.create(name: type) }

# ーーーーーーーーend bank_account_typeーーーーーーーー#

User.create(id: 1, email: "test@example.com", password: "password", confirmed_at: Time.zone.now, provider: "test")
User.create(id: 2, email: "admin@example.com", password: "password", confirmed_at: Time.zone.now, provider: "admin")

# ーーーーーーーーend user_data ーーーーーーーー#

Profile.seed do |s|
  s.user = User.find(1)
  s.first_name = "太郎"
  s.last_name = "山本"
end

Profile.seed do |s|
  s.user = User.find(2)
  s.first_name = "花子"
  s.last_name = "石川"
end

# ーーーーーーーーend profile_data ーーーーーーーー#

EmailTemplate.create(
  email_type: 0,
  subject: "身分証明証の登録が完了しました",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %> さん、こんにちは！</p>\r\n\r\n    <p>身分証明証の登録が完了しました。</p>\r\n\r\n    <p>これから、私達のサービスを利用することができます。</p>\r\n\r\n    <p>以下のリンクからサービスをご利用ください。</p>\r\n\r\n    <%= link_to \"サービスのご利用はこちら\", root_url %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %> さん、こんにちは！\r\n\r\n身分証明証の登録が完了しました。\r\n\r\nこれから、私達のサービスを利用することができます。\r\n\r\n以下のリンクからサービスをご利用ください。\r\n\r\n<%= link_to \"サービスのご利用はこちら\", root_url %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n\r\n"
)

EmailTemplate.create(
  email_type: 1,
  subject: "身分証明証の登録ができませんでした",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %> さん、こんにちは！</p>\r\n\r\n    <p>大変申し訳ありませんが、身分証明証を登録することができませんでした。</p>\r\n\r\n    <p>以下の理由を確認して、こちらから再アップロードをお願いします。</p>\r\n\r\n    <%= link_to \"再アップロードはこちらから\", profile_identification_url %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %> さん、こんにちは！\r\n\r\n大変申し訳ありませんが、身分証明証を登録することができませんでした。\r\n\r\n以下の理由を確認して、こちらから再アップロードをお願いします。\r\n\r\n<%= link_to \"再アップロードはこちらから\", profile_identification_url %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>"
)

EmailTemplate.create(
  email_type: 2,
  subject: "新しいメッセージが届きました！",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <p><%= @from_user.profile.full_name %>さんからメッセージが届きました！</p>\r\n\r\n    <p>以下のリンクから、内容をご確認ください。</p>\r\n\r\n    <%= link_to \"メッセージの確認はこちらから\", message_thread_url(@locale, @message_thread) %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<%= @from_user.profile.full_name %>さんからメッセージが届きました！/p>\r\n\r\n以下のリンクから、内容をご確認ください。\r\n\r\n<%= link_to \"メッセージの確認はこちらから\", message_thread_url(@locale, @message_thread) %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n"
)

EmailTemplate.create(
  email_type: 3,
  subject: "新しい予約リクエストが届きました！",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <p><%= @from_user.profile.full_name %>さんから予約リクエストが届きました！</p>\r\n\r\n    <p>以下のリンクから、内容をご確認ください。</p>\r\n\r\n    <%= link_to \" 予約リクエストの確認はこちらから\", dashboard_host_reservation_manager_url %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<%= @from_user.profile.full_name %>さんから予約リクエストが届きました！/p>\r\n\r\n以下のリンクから、内容をご確認ください。\r\n\r\n<%= link_to \" 予約リクエストの確認はこちらから\", dashboard_host_reservation_manager_url %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n"
)

EmailTemplate.create(
  email_type: 4,
  subject: "予約がキャンセルされました/予約が保留されました/予約が成立しました！/予約が不成立となりました(こちらは変更できません)",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <p><%= @from_user.profile.full_name %>さんが予約リクエストを更新しました！</p>\r\n\r\n    <p>以下のリンクから、内容をご確認ください。</p>\r\n\r\n    <% if @dest ==\"host\" %>\r\n      <%= link_to \"予約リクエストの確認はこちらから\", dashboard_host_reservation_manager_url %>\r\n    <% elsif @dest == \"guest\" %>\r\n      <%= link_to \"予約リクエストの確認はこちらから\", dashboard_guest_reservation_manager_url %>\r\n    <% end %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<%= @from_user.profile.full_name %>さんが予約リクエストを更新しました！/p>\r\n\r\n以下のリンクから、内容をご確認ください。\r\n\r\n<% if @dest == \"host\" %>\r\n  <%= link_to \"予約リクエストの確認はこちらから\", dashboard_host_reservation_manager_url %>\r\n<% elsif @dest == \"guest\" %>\r\n  <%= link_to \"予約リクエストの確認はこちらから\", dashboard_guest_reservation_manager_url %>\r\n<% end %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n"
)

EmailTemplate.create(
  email_type: 5,
  subject: "レビューの記入をしませんか？",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n    <p><%= @host_user.profile.full_name %>さん主催のリスティング、<%= @listing.title  %>(<%= schedule_str %>)へのレビューを行いませんか？</p>\r\n\r\n    <p>以下のリンクから、レビューの記入ができます。</p>\r\n\r\n    <%= link_to \"レビューの記入はこちらから\", new_reservation_reviews_url(@locale, @reservation.id) %>\r\n\r\n    <p>レビューを記入すると、ホストの方より返信がきます。</p>\r\n\r\n    <p>レビューの返答が来ると、レビューは公開されます。</p>\r\n\r\n    <p>なおレビューの書き込みは、<%= Settings.review.expiration_date %>日間有効です。</p>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n<%= @host_user.profile.full_name %>さん主催のリスティング、タイトル(18/04/18〜18/04/21)へのレビューを行いませんか？\r\n\r\n以下のリンクから、レビューの記入ができます。\r\n\r\n<%= link_to \"レビューの記入はこちらから\", new_reservation_reviews_url(@locale, @reservation.id) %>\r\n\r\nレビューを記入すると、ホストの方より返信がきます。\r\n\r\nレビューの返答が来ると、レビューは公開されます。\r\n\r\nなおレビューの書き込みは、<%= Settings.review.expiration_date %>日間有効です。\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>"
)

EmailTemplate.create(
  email_type: 6,
  subject: "レビューが公開されました",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n    <p><%= @host_user.profile.full_name %>さん主催のリスティング、<%= @listing.title  %>(<%= schedule_str %>)へのレビューが公開されました</p>\r\n\r\n    <p>以下のリンクから、レビューの確認ができます。</p>\r\n\r\n    <%= link_to \"レビューの確認はこちらから\", listing_url(@locale, @reservation.listing_id) %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n<%= @host_user.profile.full_name %>さん主催のリスティング、<%= @listing.title  %>(<%= schedule_str %>)へのレビューが公開されました\r\n\r\n以下のリンクから、レビューの確認ができます。\r\n\r\n<%= link_to \"レビューの確認はこちらから\", listing_url(@locale, @reservation.listing_id) %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n--\r\n<%= @signature.body %>"
)

EmailTemplate.create(
  email_type: 7,
  subject: "レビューへの返信を記入しましょう",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n\r\n<p><%= @listing.title  %>(<%=schedule_str %>)に参加していただいた、<%= @guest_user.profile.full_name  %>さんへのレビューを記入しましょう</p>\r\n\r\n    <p>以下のリンクから、レビューが記入できます</p>\r\n\r\n    <%= link_to \"レビューの記入はこちらから\", new_reservation_reviews_review_replies_url(@locale, @reservation.id) %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n<%= @listing.title  %>(<%= schedule_str %>)に参加していただいた、<%= @guest_user.profile.full_name  %>さんへのレビューを記入しましょう\r\n\r\n以下のリンクから、レビューが記入できます\r\n\r\n<%= link_to \"レビューの記入はこちらから\", new_reservation_reviews_review_replies_url(@locale, @reservation.id) %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n--\r\n<%= @signature.body %>"
)

EmailTemplate.create(
  email_type: 8,
  subject: "ユーザー仮登録されました",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p>ようこそ！</p>\r\n\r\n    <p>ご登録いただきありがとうございます</p>\r\n\r\n    <p>下記アドレスにアクセスし、登録処理を完了して下さい。</p>\r\n\r\n    <%= link_to \"登録はこちら\", confirmation_url(@resource, confirmation_token: @token)  %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "ようこそ！\r\n\r\nご登録いただきありがとうございます。\r\n\r\n下記アドレスにアクセスし、登録処理を完了して下さい。\r\n\r\n<%= link_to \"登録はこちら\", confirmation_url(@resource, confirmation_token: @token)  %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n"
)

EmailTemplate.create(
  email_type: 9,
  subject: "アカウントの凍結解除について",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p>こんにちは、<%= @resource.email %></p>\r\n\r\n    <p>不正なアクセスが複数回行われたため、アカウントがロックされています。</p>\r\n\r\n    <p>以下のリンクをクリックして、ロックを解除してください。</p>\r\n\r\n    <%= link_to \"ロック解除はこちら\", unlock_url(@resource, unlock_token: @token)  %>\r\n \r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n\r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n\r\n</html>",
  text_body: "\r\nこんにちわ！！\r\n\r\n不正なアクセスが複数回行われたため、アカウントがロックされています。\r\n\r\n以下のリンクをクリックして、ロックを解除してください。\r\n\r\n<%=link_to \"ロック解除はこちら\", unlock_url(@resource, unlock_token: @token)  %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>"
)

EmailTemplate.create(
  email_type: 10,
  subject: "メールアドレスの変更に関して",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p>下記アドレスにアクセスし、メールアドレス変更処理を完了して下さい。</p>\r\n\r\n    <%= link_to \"アドレス変更はこちら\", confirmation_url(@resource, confirmation_token: @token)  %>\r\n \r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n\r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "下記アドレスにアクセスし、メールアドレス変更処理を完了して下さい。\r\n\r\n<%= link_to \"アドレス変更はこちら\", confirmation_url(@resource, confirmation_token: @token) %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n"
)

EmailTemplate.create(
  email_type: 11,
  subject: "パスワードの再設定に関して",
  html_body: "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p>こんにちは、<%= @resource.email %>！</p>\r\n\r\n    <p>下のリンクにアクセスするとパスワードの変更を行うことができます。</p>\r\n\r\n    <%= link_to \"パスワード変更はこちらから\", edit_password_url(@resource, reset_password_token: @token) %>\r\n \r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n\r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>",
  text_body: "こんにちは、<%= @resource.email %>!!\r\n\r\n下のリンクにアクセスするとパスワードの変更を行うことができます。\r\n\r\n<%= link_to \"パスワード変更はこちらから\", edit_password_url(@resource, reset_password_token: @token) %>\r\n\r\nあなたのパスワードは、上記のリンクにアクセスするまで変更されません。\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>"
)

# # ーーーーーーーーend email_templates_data ーーーーーーーー#

EmailTemplateSignature.seed do |obj|
  obj.id = 1
  obj.body = "サービス名"
end

# # ーーーーーーーーend email_templates_signature_data ーーーーーーーー#