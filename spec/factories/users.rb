FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "airbnbclone-dev+user#{i}@bulbcorp.jp" }
    password 'password'
    uid { User.create_unique_string }
    confirmed_at DateTime.now

    after(:create) do |user|
      user.profile = create(:profile, user: user)
    end

    factory :female_user do
      after(:create) do |user|
        user.profile = create(:profile, user: user, gender: 0)
      end
    end

    factory :male_user do
      after(:create) do |user|
        user.profile = create(:profile, user: user, gender: 1)
      end
    end
  end
end
