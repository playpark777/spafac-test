FactoryBot.define do
  factory :listing do
    association :user, factory: :user
    sequence(:title) { |i| "サンプルリスティング%02d" % i }
    charter_type { Listing.charter_types.to_a.sample[0] }
    capacity { rand(1..10) }
    price { 5000 * rand(1..10) }
    description { "サンプルのリスティングです。" }
    zipcode 0000000
    location { Gimei.address.kanji }
    cover_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'pic', "pic#{format("%03d", rand(1..11))}.jpg")) }
    cover_image_caption ""
    open false

    after(:create) do |listing|
      listing.listing_images.create(
        FactoryBot.attributes_for(:listing_image, listing: listing)
      )
    end

    factory :opened_listing do
      open true
    end

    factory :invalid_listing do
      title ""
    end
  end
end
