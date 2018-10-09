FactoryBot.define do
  factory :top_page_belt_image do
    sequence(:tagline_ja) { |i| "たぐらいん_#{i}" }
    sequence(:sub_tagline_ja) { |i| "さぶたぐらいん_#{i}" }
    sequence(:tagline_en) { |i| "tagline_#{i}" }
    sequence(:sub_tagline_en) { |i| "sub_tagline_#{i}" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'pic', "pic#{format("%03d", rand(1..11))}.jpg")) }
    image_flg true
    link_url "http://airbnb-clones.herokuapp.com"

    trait :top_page_belt_image_no_image do
      image ""
      image_flg false
      color "898989"
    end

    trait :top_page_belt_image_link_url_staging do
      link_url "http://airbnb-clones-staging.herokuapp.com"
    end
    trait :top_page_belt_image_link_url_localhost do
      link_url "http://localhost:3000"
    end
    trait :top_page_belt_image_link_url_google do
      link_url "http://www.google.com"
    end

  end
end
