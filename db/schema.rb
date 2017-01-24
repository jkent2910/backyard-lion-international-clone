# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170107055325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athlete_coaches", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.string   "name"
    t.string   "title"
    t.string   "email"
    t.string   "phone"
    t.string   "school"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "athlete_experiences", force: :cascade do |t|
    t.string   "primary_position"
    t.string   "secondary_position"
    t.string   "team_name"
    t.text     "description"
    t.integer  "athlete_profile_id"
    t.string   "level"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "sport"
    t.boolean  "present"
    t.integer  "start_date"
    t.integer  "end_date"
  end

  create_table "athlete_interests", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "athlete_profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "rank_order"
  end

  add_index "athlete_interests", ["athlete_profile_id"], name: "index_athlete_interests_on_athlete_profile_id", using: :btree
  add_index "athlete_interests", ["team_id"], name: "index_athlete_interests_on_team_id", using: :btree

  create_table "athlete_notes", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.integer  "team_id"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "athlete_notifications", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.integer  "notification_type"
    t.boolean  "viewed",             default: false, null: false
    t.integer  "other_user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "athlete_photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "athlete_profile_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "primary_photo",      default: false, null: false
  end

  create_table "athlete_profiles", force: :cascade do |t|
    t.integer  "gender"
    t.string   "first_language"
    t.string   "second_language"
    t.string   "third_language"
    t.date     "birthday"
    t.integer  "height_feet"
    t.integer  "height_inches"
    t.integer  "weight"
    t.string   "primary_citizenship"
    t.string   "secondary_citizenship"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id"
    t.boolean  "passport_ready",               default: false, null: false
    t.boolean  "references_available",         default: false, null: false
    t.boolean  "agent_used",                   default: false, null: false
    t.boolean  "actively_looking",             default: false, null: false
    t.boolean  "coaching_experience",          default: false, null: false
    t.string   "desired_salary"
    t.text     "other_benefits"
    t.text     "resume"
    t.float    "athlete_height"
    t.integer  "age"
    t.boolean  "player_interest",              default: false, null: false
    t.boolean  "coach_interest",               default: false, null: false
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.integer  "express_interest_count",       default: 0
    t.decimal  "profile_strength"
  end

  create_table "athlete_ratings", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "athlete_profile_id"
    t.integer  "rating"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "athlete_recommendations", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.string   "giver_first_name"
    t.string   "giver_last_name"
    t.string   "giver_relationship"
    t.string   "giver_position"
    t.text     "recommendation_text"
    t.integer  "giver_athlete_profile_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "athlete_skills", force: :cascade do |t|
    t.string   "name"
    t.string   "units"
    t.integer  "athlete_profile_id"
    t.string   "result"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "athlete_video_comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "athlete_video_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "athlete_videos", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.integer  "athlete_profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "benefit_ratings", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.integer  "benefit_id"
    t.integer  "benefit_rating"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "benefit_ratings", ["athlete_profile_id"], name: "index_benefit_ratings_on_athlete_profile_id", using: :btree

  create_table "benefits", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.string   "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_athletes", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.integer  "user_id"
    t.integer  "rank_order"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "skill_endorsements", force: :cascade do |t|
    t.integer  "athlete_profile_id"
    t.integer  "endorser_id"
    t.integer  "athlete_skill_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subscription_level"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "customer_id"
  end

  create_table "team_benefit_ratings", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "benefit_id"
    t.integer  "benefit_rating"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "team_benefit_ratings", ["team_id"], name: "index_team_benefit_ratings_on_team_id", using: :btree

  create_table "team_contacts", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_notifications", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "notification_type"
    t.boolean  "viewed",            default: false, null: false
    t.integer  "other_user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "team_photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "team_id"
    t.boolean  "primary_photo",      default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "team_video_comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "team_video_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "team_videos", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.integer  "team_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "sport"
    t.string   "country"
    t.string   "town"
    t.string   "level"
    t.integer  "gender"
    t.string   "website"
    t.string   "season"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "team_name"
    t.text     "other_benefits"
    t.string   "salary"
    t.boolean  "looking_games"
    t.text     "additional_info"
    t.boolean  "looking_for_players",      default: false, null: false
    t.boolean  "looking_for_coaches",      default: false, null: false
    t.string   "cover_photo_file_name"
    t.string   "cover_photo_content_type"
    t.integer  "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "user_type"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "team_id"
    t.boolean  "team_validated",         default: false, null: false
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "paid_subscription",      default: false, null: false
    t.integer  "team_view_count",        default: 0
    t.integer  "message_count",          default: 0
    t.integer  "athlete_view_count",     default: 0
    t.integer  "saved_athletes_count",   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wanted_positions", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "position_id"
    t.integer  "priority"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
