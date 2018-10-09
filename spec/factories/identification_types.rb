FactoryBot.define do
  factory :identification_type do
    sequence(:name) { |i| "サンプルタイプ#{i}" }
    available true

    factory :unavailable_identification_type do
      available false
    end
  end
end
