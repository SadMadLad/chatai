# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_12_203845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_chat_maps", primary_key: ["account_id", "chat_id"], force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "chat_id"], name: "index_account_chat_maps_on_account_id_and_chat_id", unique: true
    t.index ["account_id"], name: "index_account_chat_maps_on_account_id"
    t.index ["chat_id"], name: "index_account_chat_maps_on_chat_id"
  end

  create_table "account_tokens", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "scope", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "scope"], name: "index_account_tokens_on_account_id_and_scope", unique: true
    t.index ["account_id"], name: "index_account_tokens_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "active_at_chatai", default: false, null: false
    t.boolean "active_at_frontend", default: false, null: false
    t.integer "role", default: 0, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.text "tagline"
    t.datetime "latest_message_at"
    t.uuid "unique_identifier", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unique_identifier"], name: "index_accounts_on_unique_identifier", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_comments", force: :cascade do |t|
    t.string "admin_commentable_type", null: false
    t.bigint "admin_commentable_id", null: false
    t.bigint "commenter_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_commentable_type", "admin_commentable_id"], name: "index_admin_comments_on_admin_commentable"
    t.index ["commenter_id"], name: "index_admin_comments_on_commenter_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "chat_status"
    t.integer "chat_type", default: 0, null: false
    t.string "chat_title"
    t.text "chat_description"
    t.datetime "latest_message_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "favoratable_type", null: false
    t.bigint "favoratable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_favorites_on_account_id"
    t.index ["favoratable_type", "favoratable_id"], name: "index_favorites_on_favoratable"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "platform", null: false
    t.text "feedback_body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_feedbacks_on_account_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id", null: false
    t.integer "role", default: 0, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "ml_models", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "model_type", null: false
    t.string "identifier", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.jsonb "parameters_with_order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ml_models_on_account_id"
    t.index ["identifier"], name: "index_ml_models_on_identifier", unique: true
  end

  create_table "prediction_params", force: :cascade do |t|
    t.bigint "ml_model_id", null: false
    t.integer "param_type", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.jsonb "possible_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ml_model_id"], name: "index_prediction_params_on_ml_model_id"
    t.index ["name"], name: "index_prediction_params_on_name", unique: true
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "subreddit_posts", force: :cascade do |t|
    t.bigint "subreddit_id", null: false
    t.integer "num_comments", null: false
    t.integer "subreddit_subscribers", null: false
    t.integer "ups", null: false
    t.float "upvote_ratio", null: false
    t.bigint "created_utc", null: false
    t.string "url", null: false
    t.string "author", null: false
    t.string "author_fullname", null: false
    t.string "name", null: false
    t.string "permalink", null: false
    t.string "score", null: false
    t.string "subreddit_name_prefixed", null: false
    t.string "title", null: false
    t.text "selftext"
    t.text "selftext_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permalink"], name: "index_subreddit_posts_on_permalink", unique: true
    t.index ["subreddit_id"], name: "index_subreddit_posts_on_subreddit_id"
  end

  create_table "subreddits", force: :cascade do |t|
    t.integer "subreddit_subscribers"
    t.string "subreddit", null: false
    t.string "subreddit_url", null: false
    t.datetime "latest_scraped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subreddit"], name: "index_subreddits_on_subreddit", unique: true
    t.index ["subreddit_url"], name: "index_subreddits_on_subreddit_url", unique: true
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_reports", force: :cascade do |t|
    t.float "cloud"
    t.float "feels_like_temperature"
    t.float "gust_kph"
    t.float "humidity"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.float "precip_mm"
    t.float "pressure_mb"
    t.float "temperature", null: false
    t.float "uv"
    t.float "vis_km"
    t.float "wind_degree"
    t.float "wind_kph", null: false
    t.bigint "localtime_epoch"
    t.bigint "last_updated_epoch"
    t.string "condition_text"
    t.string "country", null: false
    t.string "name", null: false
    t.string "region", null: false
    t.string "timezone_id"
    t.string "wind_direction"
    t.datetime "last_updated"
    t.datetime "localtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_chat_maps", "accounts"
  add_foreign_key "account_chat_maps", "chats"
  add_foreign_key "account_tokens", "accounts"
  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "accounts"
  add_foreign_key "feedbacks", "accounts"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "chats"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "subreddit_posts", "subreddits"
end
