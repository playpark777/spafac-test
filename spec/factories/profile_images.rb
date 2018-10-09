FactoryBot.define do
  factory :profile_image do
    user
    profile
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', 'profile_images', "profile_image#{rand(0..2)}.png")) }
    caption ""
  end
end
