FactoryBot.define do
  factory :listing_image do
    listing
    order_num { ListingImage.where(listing_id: self.listing.id).size }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'pic', "pic#{format("%03d", rand(1..11))}.jpg")) }
    caption "リスティングのイメージです。"
  end
end
