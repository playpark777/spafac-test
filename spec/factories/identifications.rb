FactoryBot.define do
  factory :identification do
    association :profile, factory: :profile
    image1 { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'sample', "id#{rand(0..4)}.jpg")) }
    image2 ""
    image3 ""
    note "身分証明証です。"

    factory :approved_identification do
      status :approved
      processed_at DateTime.now
      processed_by { AdminUser.first || AdminUser.create(
        email: "admin@example.com", password: "password"
      ) }

      identification_type_id { (IdentificationType.first ||
                                FactoryBot.create(:identification_type)).id }
    end

    factory :rejected_identification do
      status :rejected
      processed_at DateTime.now
      processed_by { AdminUser.first || AdminUser.create(
        email: "admin@example.com", password: "password"
      ) }
      reason "画像が不鮮明です。"
    end

    factory :invalid_identification do
      image1 ""
    end
  end
end
