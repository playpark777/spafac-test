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
