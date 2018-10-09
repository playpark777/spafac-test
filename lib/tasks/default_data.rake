namespace :default_data do
  desc 'set default data'
  task set: :environment do
    exec "rake db:seed_fu FILTER=top_page_default_data,identification_type,bank,email_template"
  end

  desc 'review_app用のデフォルトデータ作成'
  task set_sample_data: :environment do
    # Sample review and review_reply
    FactoryBot.create_list(:review, 3)
    FactoryBot.create_list(:review_reply, 3)

    # Sample Host user and listing (user1@example.com)
    host = FactoryBot.create(:user)
    FactoryBot.create_list(:opened_listing, 3, user: host)
    FactoryBot.create(:bank_account, profile: host.profile)

    # Sample Guest user and reservation (Guest email: user2@example.com)
    guest = FactoryBot.create(:user)
    FactoryBot.create(:reservation, listing: Listing.first, host: host, guest: guest)
    FactoryBot.create(:bank_account, profile: guest.profile)

    # Other Sample Datas
    FactoryBot.create_list(:opened_listing, 3)

    FactoryBot.create_list(:requested_reservation, 3)
    FactoryBot.create_list(:accepted_reservation, 3)
  end

  desc 'set test_user_data ONLY FOR DEVELOPMENT'
  task test_user_data: :environment do
    exec "rake db:seed_fu FIXTURE_PATH=db/fixtures/development"
  end

  desc 'review_app用のデフォルトデータ作成'
  task set_review_app: :environment do
    if Rails.env == 'review_app'
      exec "rake db:seed_fu FILTER=top_page_default_data,identification_type,bank"
    end
  end
end
