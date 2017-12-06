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

ActiveRecord::Schema.define(version: 20170923090933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: :cascade do |t|
    t.string   "title_text"
    t.string   "description"
    t.jsonb    "social_links", default: "{}"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["social_links"], name: "index_abouts_on_social_links", using: :gin
  end

  create_table "album_categories", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_id"], name: "index_album_categories_on_album_id", using: :btree
    t.index ["category_id"], name: "index_album_categories_on_category_id", using: :btree
  end

  create_table "album_recipients", force: :cascade do |t|
    t.boolean  "is_email_sent"
    t.string   "custom_message"
    t.integer  "album_id"
    t.integer  "contact_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "minimum_photo_selection"
    t.boolean  "allow_comments",          default: false
    t.integer  "recipient_type",          default: 0
    t.index ["album_id"], name: "index_album_recipients_on_album_id", using: :btree
    t.index ["contact_id"], name: "index_album_recipients_on_contact_id", using: :btree
  end

  create_table "albums", force: :cascade do |t|
    t.string   "album_name"
    t.boolean  "is_private",           default: true
    t.integer  "status",               default: 1
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "delivery_status",      default: 0
    t.boolean  "portfolio_visibility", default: false
    t.string   "passcode"
    t.string   "slug"
    t.index ["deleted_at"], name: "index_albums_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_albums_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.integer  "status",        default: 1
    t.integer  "user_id"
    t.index ["deleted_at"], name: "index_categories_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "message"
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_comments_on_photo_id", using: :btree
  end

  create_table "contact_details", force: :cascade do |t|
    t.text     "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_contact_details_on_deleted_at", using: :btree
  end

  create_table "contact_messages", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "status",     default: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.string   "token"
    t.index ["deleted_at"], name: "index_contacts_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_contacts_on_user_id", using: :btree
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "homepage_photos", force: :cascade do |t|
    t.boolean  "is_active",                   default: false
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "photo_id"
    t.string   "homepage_image_file_name"
    t.string   "homepage_image_content_type"
    t.integer  "homepage_image_file_size"
    t.datetime "homepage_image_updated_at"
    t.index ["photo_id"], name: "index_homepage_photos_on_photo_id", using: :btree
    t.index ["user_id"], name: "index_homepage_photos_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photo_title"
    t.integer  "status",             default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "deleted_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_cover_photo",     default: false
    t.integer  "user_id"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.boolean  "is_selected",        default: false
    t.index ["deleted_at"], name: "index_photos_on_deleted_at", using: :btree
    t.index ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id", using: :btree
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "service_icons", force: :cascade do |t|
    t.integer  "status",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "icon_image"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_service_icons_on_deleted_at", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "service_name"
    t.string   "description"
    t.integer  "status",          default: 1
    t.integer  "service_icon_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_services_on_deleted_at", using: :btree
    t.index ["service_icon_id"], name: "index_services_on_service_icon_id", using: :btree
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "client_name"
    t.integer  "contact_id"
    t.text     "message"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.integer  "rating"
    t.index ["contact_id"], name: "index_testimonials_on_contact_id", using: :btree
    t.index ["deleted_at"], name: "index_testimonials_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_testimonials_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "status",                 default: 1
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "video_thumb"
    t.string   "title"
    t.integer  "video_type"
    t.string   "video_url"
    t.integer  "status"
    t.index ["user_id"], name: "index_videos_on_user_id", using: :btree
  end

  create_table "watermarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_watermarks_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_watermarks_on_user_id", using: :btree
  end

  add_foreign_key "album_recipients", "albums"
  add_foreign_key "album_recipients", "contacts"
  add_foreign_key "comments", "photos"
  add_foreign_key "homepage_photos", "photos"
  add_foreign_key "homepage_photos", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "services", "service_icons"
  add_foreign_key "testimonials", "contacts"
  add_foreign_key "testimonials", "users"
  add_foreign_key "videos", "users"
  add_foreign_key "watermarks", "users"
end
