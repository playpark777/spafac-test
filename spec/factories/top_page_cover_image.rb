FactoryBot.define do
  factory :top_page_cover_image do
    sequence(:order_num) { |i| i }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'pic', "pic#{format("%03d", rand(1..11))}.jpg")) }
  end
end
