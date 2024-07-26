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

ActiveRecord::Schema[7.1].define(version: 2024_07_26_101748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "vector"

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
    t.integer "favorites_count", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.text "tagline"
    t.datetime "latest_message_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "collectable_maps", force: :cascade do |t|
    t.string "collectable_type", null: false
    t.bigint "collectable_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collectable_type", "collectable_id"], name: "index_collectable_maps_on_collectable"
    t.index ["collection_id", "collectable_id", "collectable_type"], name: "idx_on_collection_id_collectable_id_collectable_typ_702ff00160", unique: true
    t.index ["collection_id"], name: "index_collectable_maps_on_collection_id"
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.boolean "public", default: true, null: false
    t.integer "collectable_maps_count", default: 0, null: false
    t.integer "favorites_count", default: 0, null: false
    t.integer "items_count", default: 0, null: false
    t.string "color", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_collections_on_account_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.integer "likes_count", default: 0, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "embeddings", force: :cascade do |t|
    t.string "embeddable_type", null: false
    t.bigint "embeddable_id", null: false
    t.vector "embedding", limit: 768, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embeddable_id", "embeddable_type"], name: "index_embeddings_on_embeddable_id_and_embeddable_type", unique: true
    t.index ["embeddable_type", "embeddable_id"], name: "index_embeddings_on_embeddable"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "favoritable_type", null: false
    t.bigint "favoritable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "favoritable_id", "favoritable_type"], name: "idx_on_account_id_favoritable_id_favoritable_type_a8ff303bb6", unique: true
    t.index ["account_id"], name: "index_favorites_on_account_id"
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "platform", null: false
    t.text "feedback_body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_feedbacks_on_account_id"
  end

  create_table "flash_cards", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "card_style", default: 0, null: false
    t.integer "collectable_maps_count", default: 0, null: false
    t.integer "favorites_count", default: 0, null: false
    t.string "color", default: "#84cc16", null: false
    t.text "answer", null: false
    t.text "prompt", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_flash_cards_on_account_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "likeable_id", "likeable_type"], name: "index_likes_on_account_id_and_likeable_id_and_likeable_type", unique: true
    t.index ["account_id"], name: "index_likes_on_account_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
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

  create_table "posts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "likes_count", default: 0, null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_posts_on_account_id"
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

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.boolean "correct", default: false, null: false
    t.text "option_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.boolean "multiple_answers", default: false, null: false
    t.integer "score", default: 1, null: false
    t.text "question_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quiz_undertakings", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "quiz_id", null: false
    t.float "score", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_quiz_undertakings_on_account_id"
    t.index ["quiz_id"], name: "index_quiz_undertakings_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "account_id"
    t.boolean "published", default: false, null: false
    t.boolean "timed", default: false, null: false
    t.integer "collectable_maps_count", default: 0, null: false
    t.integer "favorites_count", default: 0, null: false
    t.integer "questions_count", default: 0, null: false
    t.integer "quiz_undertakings_count", default: 0, null: false
    t.integer "ratings_count", default: 0, null: false
    t.integer "timer"
    t.integer "total_score", default: 0, null: false
    t.integer "total_rating", default: 0, null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "latest_taken_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_quizzes_on_account_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "rateable_type", null: false
    t.bigint "rateable_id", null: false
    t.integer "rating", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ratings_on_account_id"
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable"
  end

  create_table "request_logs", force: :cascade do |t|
    t.bigint "account_id"
    t.string "action", null: false
    t.string "controller", null: false
    t.string "original_url", null: false
    t.jsonb "extra_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_request_logs_on_account_id"
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
    t.index ["subreddit_id"], name: "index_subreddit_posts_on_subreddit_id"
    t.index ["url"], name: "index_subreddit_posts_on_url", unique: true
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

  create_table "tag_maps", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id", "taggable_id", "taggable_type"], name: "index_tag_maps_on_tag_id_and_taggable_id_and_taggable_type", unique: true
    t.index ["tag_id"], name: "index_tag_maps_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tag_maps_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "tag_type", default: 0, null: false
    t.string "tag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag"], name: "index_tags_on_tag", unique: true
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
  add_foreign_key "collectable_maps", "collections"
  add_foreign_key "collections", "accounts"
  add_foreign_key "comments", "accounts"
  add_foreign_key "favorites", "accounts"
  add_foreign_key "feedbacks", "accounts"
  add_foreign_key "flash_cards", "accounts"
  add_foreign_key "likes", "accounts"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "chats"
  add_foreign_key "posts", "accounts"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quiz_undertakings", "accounts"
  add_foreign_key "quiz_undertakings", "quizzes"
  add_foreign_key "quizzes", "accounts"
  add_foreign_key "ratings", "accounts"
  add_foreign_key "request_logs", "accounts"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "subreddit_posts", "subreddits"
  add_foreign_key "tag_maps", "tags"
end
