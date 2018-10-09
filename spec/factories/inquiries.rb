FactoryBot.define do
  factory :inquiry do
    transient do
      dummy_name { Gimei.kanji }
      dummy_email { "airbnbclone-dev+user#{rand(1..10)}@bulbcorp.jp" }
    end

    sequence(:title) { |i|  "Sample Inquery #{i}" }
    name { dummy_name }
    email { dummy_email }
    body "Lorem Ipsum\nLorem Ipsum\n"
    remote_ip  "127.0.0.1"
    user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"

    factory :invalid_inquiry do
      body ''
    end
  end
end
