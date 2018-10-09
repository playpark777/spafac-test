FactoryBot.define do
  factory :profile do
    transient do
      gimei { Gimei.new }
    end

    association :user, factory: :user
    first_name { gimei.first.kanji }
    last_name { gimei.last.kanji}
    gender { gimei.female? ? 0 : 1 }
    birthday { Faker::Date.between(50.years.ago, 20.years.ago) }
    phone "09000000000"
    zipcode 0000000
    location { gimei.address.kanji }
    self_introduction "こんにちは。よろしくお願いします。"

    after(:create) do |profile|
      profile.profile_image = FactoryBot.create(:profile_image,
                                                 user: profile.user, profile: profile)
      profile.identification = create(:approved_identification,
                                      profile: profile)
    end
  end
end
