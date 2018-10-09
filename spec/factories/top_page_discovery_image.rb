FactoryBot.define do
  factory :top_page_discovery_image do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'pic', "pic#{format("%03d", rand(1..11))}.jpg")) }
    sequence(:tagline_ja) { |i| "たぐらいん_#{i}" }
    sequence(:tagline_en) { |i| "tagline_#{i}" }
    link_url "http://airbnb-clones.herokuapp.com"
    sequence(:order_num) { |i| i }
    size { [1, 2].sample }
    show_price true

    trait :top_page_discovery_image_link_url_staging do
      link_url "http://airbnb-clones-staging.herokuapp.com"
    end
    trait :top_page_discovery_image_link_url_localhost do
      link_url "http://localhost:3000"
    end
    trait :top_page_discovery_image_link_url_google do
      link_url "http://www.google.com"
    end

    trait :top_page_discovery_image_size_0 do
      size 0
    end

    trait :top_page_discovery_image_show_price_false do
      available false
    end
  end
end
