FactoryBot.define do
  factory :review do

    association :reservation

    host_id  { reservation.host_id }
    guest_id { reservation.guest_id }
    listing_id { reservation.listing_id }
    msg "レビューのサンプルです。"
    total { rand(1..5) }

    after :create do |review|
      create :review_reply, review: review
      review.calc_average

      review.reservation.reviewed_at = Time.zone.now
      review.reservation.save!
    end
  end
end
