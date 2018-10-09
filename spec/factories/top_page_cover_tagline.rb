FactoryBot.define do
  factory :top_page_cover_tagline do
    sequence(:tagline_ja) { |i| "たぐらいん_#{i}" }
    sequence(:sub_tagline_ja) { |i| "さぶたぐらいん_#{i}" }
    sequence(:tagline_en) { |i| "tagline_#{i}" }
    sequence(:sub_tagline_en) { |i| "sub_tagline_#{i}" }
  end
end
