# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180504035123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "auths", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auths_on_user_id"
  end

  create_table "bank_account_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bank_account_types_on_name", unique: true
  end

  create_table "bank_accounts", id: :serial, force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "bank_id", null: false
    t.string "branch_code", null: false
    t.string "branch_name", null: false
    t.integer "type_of_bank_account_id", null: false
    t.string "number", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id"
    t.index ["profile_id"], name: "index_bank_accounts_on_profile_id"
    t.index ["type_of_bank_account_id"], name: "index_bank_accounts_on_type_of_bank_account_id"
  end

  create_table "banks", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "code"], name: "index_banks_on_name_and_code", unique: true
  end

  create_table "browsing_histories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "listing_id"
    t.datetime "viewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_browsing_histories_on_listing_id"
    t.index ["user_id"], name: "index_browsing_histories_on_user_id"
    t.index ["viewed_at"], name: "index_browsing_histories_on_viewed_at"
  end

  create_table "email_template_signatures", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_templates", primary_key: "email_type", id: :integer, default: nil, force: :cascade do |t|
    t.string "subject", null: false
    t.text "html_body", null: false
    t.text "text_body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emergencies", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "profile_id"
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "relationship", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_emergencies_on_profile_id"
    t.index ["user_id"], name: "index_emergencies_on_user_id"
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identification_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_identification_types_on_name", unique: true
  end

  create_table "identifications", id: :serial, force: :cascade do |t|
    t.integer "profile_id"
    t.string "image1", default: "", null: false
    t.string "image2", default: ""
    t.string "image3", default: ""
    t.string "note", default: ""
    t.integer "status", default: 0, null: false
    t.string "reason", default: ""
    t.datetime "processed_at"
    t.integer "processed_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "identification_type_id"
    t.index ["profile_id"], name: "index_identifications_on_profile_id"
  end

  create_table "inquiries", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.text "body", null: false
    t.integer "status", default: 0, null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent", default: "", null: false
    t.string "remote_ip", default: "", null: false
    t.integer "admin_user_id"
    t.text "note", default: ""
    t.index ["user_id"], name: "index_inquiries_on_user_id"
  end

  create_table "listing_images", id: :serial, force: :cascade do |t|
    t.integer "listing_id"
    t.string "image", default: ""
    t.integer "order_num"
    t.string "caption", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_listing_images_on_listing_id"
  end

  create_table "listing_pvs", id: :serial, force: :cascade do |t|
    t.integer "listing_id"
    t.date "viewed_at"
    t.integer "pv", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_listing_pvs_on_listing_id"
    t.index ["viewed_at", "listing_id"], name: "index_listing_pvs_on_viewed_at_and_listing_id", unique: true
  end

  create_table "listings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_count", default: 0
    t.float "ave_total", default: 0.0
    t.float "ave_accuracy", default: 0.0
    t.float "ave_communication", default: 0.0
    t.float "ave_cleanliness", default: 0.0
    t.float "ave_location", default: 0.0
    t.float "ave_check_in", default: 0.0
    t.float "ave_cost_performance", default: 0.0
    t.boolean "open", default: false
    t.string "zipcode"
    t.string "location", default: ""
    t.decimal "longitude", precision: 9, scale: 6, default: "0.0"
    t.decimal "latitude", precision: 9, scale: 6, default: "0.0"
    t.boolean "delivery_flg", default: false
    t.integer "price", default: 0
    t.text "description", default: ""
    t.string "title", default: ""
    t.integer "capacity", default: 0
    t.text "direction", default: ""
    t.string "cover_image", default: ""
    t.string "cover_image_caption", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "charter_type"
    t.index ["capacity"], name: "index_listings_on_capacity"
    t.index ["latitude"], name: "index_listings_on_latitude"
    t.index ["location"], name: "index_listings_on_location"
    t.index ["longitude"], name: "index_listings_on_longitude"
    t.index ["price"], name: "index_listings_on_price"
    t.index ["title"], name: "index_listings_on_title"
    t.index ["user_id"], name: "index_listings_on_user_id"
    t.index ["zipcode"], name: "index_listings_on_zipcode"
  end

  create_table "message_thread_users", id: :serial, force: :cascade do |t|
    t.integer "message_thread_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_thread_id", "user_id"], name: "index_message_thread_users_on_message_thread_id_and_user_id", unique: true
    t.index ["message_thread_id"], name: "index_message_thread_users_on_message_thread_id"
    t.index ["user_id"], name: "index_message_thread_users_on_user_id"
  end

  create_table "message_threads", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "message_thread_id", null: false
    t.integer "from_user_id", null: false
    t.integer "to_user_id", null: false
    t.text "content", default: "", null: false
    t.boolean "read", default: false
    t.datetime "read_at"
    t.integer "listing_id", default: 0, null: false
    t.integer "reservation_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_messages_on_from_user_id"
    t.index ["listing_id"], name: "index_messages_on_listing_id"
    t.index ["message_thread_id"], name: "index_messages_on_message_thread_id"
    t.index ["reservation_id"], name: "index_messages_on_reservation_id"
    t.index ["to_user_id"], name: "index_messages_on_to_user_id"
  end

  create_table "profile_images", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "profile_id"
    t.string "image", default: "", null: false
    t.string "caption", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_images_on_profile_id"
    t.index ["user_id"], name: "index_profile_images_on_user_id"
  end

  create_table "profile_videos", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "profile_id"
    t.string "video", default: "", null: false
    t.string "caption", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_videos_on_profile_id"
    t.index ["user_id"], name: "index_profile_videos_on_user_id"
  end

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.date "birthday"
    t.integer "gender"
    t.string "phone", default: ""
    t.boolean "phone_verification", default: false
    t.string "zipcode", default: ""
    t.string "location", default: ""
    t.text "self_introduction", default: ""
    t.string "school", default: ""
    t.string "work", default: ""
    t.string "timezone", default: ""
    t.integer "listing_count", default: 0
    t.integer "wishlist_count", default: 0
    t.integer "bookmark_count", default: 0
    t.integer "reviewed_count", default: 0
    t.integer "reservation_count", default: 0
    t.float "ave_total", default: 0.0
    t.float "ave_accuracy", default: 0.0
    t.float "ave_communication", default: 0.0
    t.float "ave_cleanliness", default: 0.0
    t.float "ave_location", default: 0.0
    t.float "ave_check_in", default: 0.0
    t.float "ave_cost_performance", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reservations", id: :serial, force: :cascade do |t|
    t.integer "host_id"
    t.integer "guest_id"
    t.integer "listing_id"
    t.integer "num_of_people", null: false
    t.text "msg", default: ""
    t.integer "progress", default: 0, null: false
    t.text "reason", default: ""
    t.datetime "review_mail_sent_at"
    t.datetime "review_expiration_date"
    t.datetime "review_landed_at"
    t.datetime "reviewed_at"
    t.datetime "reply_mail_sent_at"
    t.datetime "reply_landed_at"
    t.datetime "replied_at"
    t.datetime "review_opened_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "review_opened_mail_sent_at"
    t.date "checkin"
    t.date "checkout"
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["host_id"], name: "index_reservations_on_host_id"
    t.index ["listing_id"], name: "index_reservations_on_listing_id"
  end

  create_table "review_replies", id: :serial, force: :cascade do |t|
    t.integer "review_id"
    t.text "msg", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_review_replies_on_review_id"
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "guest_id"
    t.integer "host_id"
    t.integer "reservation_id"
    t.integer "listing_id"
    t.integer "accuracy", default: 0
    t.integer "communication", default: 0
    t.integer "cleanliness", default: 0
    t.integer "location", default: 0
    t.integer "check_in", default: 0
    t.integer "cost_performance", default: 0
    t.integer "total", default: 0
    t.text "msg", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reviews_on_guest_id"
    t.index ["host_id"], name: "index_reviews_on_host_id"
    t.index ["listing_id"], name: "index_reviews_on_listing_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "top_page_belt_images", id: :serial, force: :cascade do |t|
    t.boolean "image_flg", null: false
    t.string "image"
    t.string "color"
    t.string "tagline_ja", null: false
    t.string "sub_tagline_ja", null: false
    t.string "tagline_en", null: false
    t.string "sub_tagline_en", null: false
    t.string "link_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "top_page_cover_images", id: :serial, force: :cascade do |t|
    t.string "image", null: false
    t.integer "order_num", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_num"], name: "index_top_page_cover_images_on_order_num", unique: true
  end

  create_table "top_page_cover_taglines", id: :serial, force: :cascade do |t|
    t.string "tagline_ja", null: false
    t.string "sub_tagline_ja", null: false
    t.string "tagline_en", null: false
    t.string "sub_tagline_en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "top_page_discovery_images", id: :serial, force: :cascade do |t|
    t.string "image", null: false
    t.string "tagline_ja", null: false
    t.string "tagline_en", null: false
    t.string "link_url", null: false
    t.integer "order_num", null: false
    t.integer "size", default: 1, null: false
    t.boolean "show_price", default: false, null: false
    t.integer "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_num"], name: "index_top_page_discovery_images_on_order_num", unique: true
  end

  create_table "user_ngevents", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "listing_id"
    t.integer "reservation_id"
    t.string "reason", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_user_ngevents_on_listing_id"
    t.index ["reservation_id"], name: "index_user_ngevents_on_reservation_id"
    t.index ["user_id"], name: "index_user_ngevents_on_user_id"
  end

  create_table "user_okevents", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "listing_id"
    t.integer "reservation_id"
    t.string "reason", null: false
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_user_okevents_on_listing_id"
    t.index ["reservation_id"], name: "index_user_okevents_on_reservation_id"
    t.index ["user_id"], name: "index_user_okevents_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uid", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "username"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wishlists", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_wishlists_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "auths", "users"
  add_foreign_key "bank_accounts", "banks"
  add_foreign_key "bank_accounts", "profiles"
  add_foreign_key "browsing_histories", "listings"
  add_foreign_key "emergencies", "profiles"
  add_foreign_key "emergencies", "users"
  add_foreign_key "identifications", "profiles"
  add_foreign_key "inquiries", "users"
  add_foreign_key "listing_images", "listings"
  add_foreign_key "listing_pvs", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "message_thread_users", "message_threads"
  add_foreign_key "message_thread_users", "users"
  add_foreign_key "messages", "message_threads"
  add_foreign_key "messages", "users", column: "from_user_id"
  add_foreign_key "messages", "users", column: "to_user_id"
  add_foreign_key "profile_images", "profiles"
  add_foreign_key "profile_images", "users"
  add_foreign_key "profile_videos", "profiles"
  add_foreign_key "profile_videos", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users", column: "guest_id"
  add_foreign_key "reservations", "users", column: "host_id"
  add_foreign_key "review_replies", "reviews"
  add_foreign_key "reviews", "listings"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "reviews", "users", column: "guest_id"
  add_foreign_key "reviews", "users", column: "host_id"
  add_foreign_key "user_ngevents", "listings"
  add_foreign_key "user_ngevents", "reservations"
  add_foreign_key "user_ngevents", "users"
  add_foreign_key "user_okevents", "listings"
  add_foreign_key "user_okevents", "reservations"
  add_foreign_key "user_okevents", "users"
  add_foreign_key "wishlists", "users"
end
