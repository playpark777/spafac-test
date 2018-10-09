FactoryBot.define do
  factory :reservation do
    association :listing, factory: :opened_listing
    association :host, factory: :user
    association :guest, factory: :user
    # schedule { Faker::Date.between(1.week.since, 1.month.since) }
    num_of_people 1
    checkin { Faker::Date.between(1.week.since, 1.month.since) }
    checkout { |r| r.checkin + 3.day }
    review_expiration_date { |r| r.checkout + 1.week }


    factory :requested_reservation do
      progress :requested
    end

    factory :canceled_reservation do
      progress :canceled
    end

    factory :holded_reservation do
      progress :holded
    end

    factory :accepted_reservation do
      progress :accepted
    end

    factory :rejected_reservation do
      progress :rejected
    end

    factory :listing_closed_reservation do
      progress :listing_closed
    end
  end
end
