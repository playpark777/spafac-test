FactoryBot.define do
  factory :approved_notification_template, class: EmailTemplate do
    email_type "identification_is_approved_notification"
    subject "身分証明証の登録が完了しました"
    html_body "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %> さん、こんにちは！</p>\r\n\r\n    <p>身分証明証の登録が完了しました。</p>\r\n\r\n    <p>これから、私達のサービスを利用することができます。</p>\r\n\r\n    <p>以下のリンクからサービスをご利用ください。</p>\r\n\r\n    <%= link_to \"サービスのご利用はこちら\", root_url %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>"
    text_body "<%= @to_user.profile.full_name %> さん、こんにちは！\r\n\r\n身分証明証の登録が完了しました。\r\n\r\nこれから、私達のサービスを利用することができます。\r\n\r\n以下のリンクからサービスをご利用ください。\r\n\r\n<%= link_to \"サービスのご利用はこちら\", root_url %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>\r\n\r\n"
  end

  factory :rejected_notification_template, class: EmailTemplate do
    email_type "identification_is_rejected_notification"
    subject "身分証明証の登録ができませんでした"
    html_body "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %> さん、こんにちは！</p>\r\n\r\n    <p>大変申し訳ありませんが、身分証明証を登録することができませんでした。</p>\r\n\r\n    <p>以下の理由を確認して、こちらから再アップロードをお願いします。</p>\r\n\r\n    <%= link_to \"再アップロードはこちらから\", profile_identification_url %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>"
    text_body "<%= @to_user.profile.full_name %> さん、こんにちは！\r\n\r\n大変申し訳ありませんが、身分証明証を登録することができませんでした。\r\n\r\n以下の理由を確認して、こちらから再アップロードをお願いします。\r\n\r\n<%= link_to \"再アップロードはこちらから\", profile_identification_url %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n-- \r\n<%= @signature.body %>"
  end

  factory :review_opened_notification_template, class: EmailTemplate do
    email_type "review_opened_notification"
    subject "レビューが公開されました"
    html_body "<!doctype html>\r\n<html lang=\"ja\">\r\n  <head>\r\n    <meta content=\"text/html; charset=UTF-8\" />\r\n  </head>\r\n  <body>\r\n    <p><%= @to_user.profile.full_name %>さん、こんにちは！</p>\r\n\r\n    <% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n    <p><%= @host_user.profile.full_name %>さん主催のリスティング、<%= @listing.title  %>(<%= schedule_str %>)へのレビューが公開されました</p>\r\n\r\n    <p>以下のリンクから、レビューの確認ができます。</p>\r\n\r\n    <%= link_to \"レビューの確認はこちらから\", listing_url(nil, @reservation.listing_id) %>\r\n\r\n    <p>このメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。</p>\r\n \r\n    <footer>\r\n      -- <br>\r\n      <%= @signature.body %>\r\n    </footer>\r\n\r\n  </body>\r\n</html>"
    text_body "<%= @to_user.profile.full_name %>さん、こんにちは！\r\n\r\n<% schedule_str = \"\#{@reservation.checkin.strftime(\"%y/%m/%d\")}〜\#{@reservation.checkout.strftime(\"%y/%m/%d\")}\" %>\r\n<%= @host_user.profile.full_name %>さん主催のリスティング、<%= @listing.title  %>(<%= schedule_str %>)へのレビューが公開されました\r\n\r\n以下のリンクから、レビューの確認ができます。\r\n\r\n<%= link_to \"レビューの確認はこちらから\", listing_url(nil, @reservation.listing_id) %>\r\n\r\nこのメールにお心当たりのない方は、お手数ですがこちらよりご連絡ください。\r\n\r\n--\r\n<%= @signature.body %>"
  end
end
