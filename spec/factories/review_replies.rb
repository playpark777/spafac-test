FactoryBot.define do
  factory :review_reply, class: ReviewReply do
    association :review, factory: :review
    msg "レビューリプライのサンプルです。"

    after(:create) do |review_reply|
      review_reply.review.reservation.replied_at = Time.zone.now
      review_reply.review.reservation.review_opened_at = Time.zone.now
      review_reply.review.reservation.save!
    end
  end
end
