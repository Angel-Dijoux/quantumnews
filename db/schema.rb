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

ActiveRecord::Schema[7.1].define(version: 2024_01_09_170057) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["category"], name: "index_categories_on_category", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil
    t.string "short_id", limit: 10, default: "", null: false
    t.bigint "story_id", null: false
    t.binary "confidence_order", null: false
    t.bigint "user_id", null: false
    t.bigint "parent_comment_id"
    t.bigint "thread_id"
    t.text "comment", null: false
    t.integer "score", default: 1, null: false
    t.integer "flags", default: 0, null: false
    t.decimal "confidence", precision: 20, scale: 19, default: "0.0", null: false
    t.text "markeddown_comment"
    t.boolean "is_deleted", default: false
    t.boolean "is_moderated", default: false
    t.boolean "is_from_email", default: false
    t.bigint "hat_id"
    t.index ["comment"], name: "index_comments_on_comment"
    t.index ["confidence"], name: "confidence_idx"
    t.index ["hat_id"], name: "comments_hat_id_fk"
    t.index ["parent_comment_id"], name: "comments_parent_comment_id_fk"
    t.index ["score"], name: "index_comments_on_score"
    t.index ["short_id"], name: "short_id", unique: true
    t.index ["story_id", "short_id"], name: "story_id_short_id"
    t.index ["thread_id"], name: "thread_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "domain"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "banned_at", precision: nil
    t.integer "banned_by_user_id"
    t.string "banned_reason", limit: 200
  end

  create_table "hat_requests", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.bigint "user_id", null: false
    t.string "hat", null: false
    t.string "link", null: false
    t.text "comment", null: false
    t.index ["user_id"], name: "hat_requests_user_id_fk"
  end

  create_table "hats", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.bigint "user_id", null: false
    t.bigint "granted_by_user_id", null: false
    t.string "hat", null: false
    t.string "link"
    t.boolean "modlog_use", default: false
    t.datetime "doffed_at", precision: nil
    t.index ["granted_by_user_id"], name: "hats_granted_by_user_id_fk"
    t.index ["user_id"], name: "hats_user_id_fk"
  end

  create_table "hidden_stories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.index ["story_id"], name: "hidden_stories_story_id_fk"
    t.index ["user_id", "story_id"], name: "index_hidden_stories_on_user_id_and_story_id", unique: true
  end

  create_table "invitation_requests", force: :cascade do |t|
    t.string "code"
    t.boolean "is_verified", default: false
    t.string "email", null: false
    t.string "name", null: false
    t.text "memo"
    t.string "ip_address"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email"
    t.string "code"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "memo"
    t.datetime "used_at", precision: nil
    t.bigint "new_user_id"
    t.index ["new_user_id"], name: "invitations_new_user_id_fk"
    t.index ["user_id"], name: "invitations_user_id_fk"
  end

  create_table "keystores", force: :cascade do |t|
    t.string "key", limit: 50, default: "", null: false
    t.bigint "value"
    t.index ["key"], name: "key", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.bigint "author_user_id"
    t.bigint "recipient_user_id", null: false
    t.boolean "has_been_read", default: false
    t.string "subject", limit: 100
    t.text "body"
    t.string "short_id", limit: 30
    t.boolean "deleted_by_author", default: false
    t.boolean "deleted_by_recipient", default: false
    t.bigint "hat_id"
    t.index ["hat_id"], name: "index_messages_on_hat_id"
    t.index ["recipient_user_id"], name: "messages_recipient_user_id_fk"
    t.index ["short_id"], name: "random_hash", unique: true
  end

  create_table "mod_notes", force: :cascade do |t|
    t.bigint "moderator_user_id", null: false
    t.bigint "user_id", null: false
    t.text "note", null: false
    t.text "markeddown_note", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["id", "user_id"], name: "index_mod_notes_on_id_and_user_id"
    t.index ["moderator_user_id"], name: "mod_notes_moderator_user_id_fk"
    t.index ["user_id"], name: "mod_notes_user_id_fk"
  end

  create_table "moderations", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "moderator_user_id"
    t.bigint "story_id"
    t.bigint "comment_id"
    t.bigint "user_id"
    t.text "action"
    t.text "reason"
    t.boolean "is_from_suggestions", default: false
    t.bigint "tag_id"
    t.integer "domain_id"
    t.bigint "category_id"
    t.index ["comment_id"], name: "moderations_comment_id_fk"
    t.index ["created_at"], name: "index_moderations_on_created_at"
    t.index ["domain_id"], name: "index_moderations_on_domain_id"
    t.index ["moderator_user_id"], name: "moderations_moderator_user_id_fk"
    t.index ["story_id"], name: "moderations_story_id_fk"
    t.index ["tag_id"], name: "moderations_tag_id_fk"
    t.index ["user_id"], name: "index_moderations_on_user_id"
  end

  create_table "read_ribbons", force: :cascade do |t|
    t.boolean "is_following", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.index ["story_id"], name: "index_read_ribbons_on_story_id"
    t.index ["user_id"], name: "index_read_ribbons_on_user_id"
  end

  create_table "saved_stories", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.index ["story_id"], name: "saved_stories_story_id_fk"
    t.index ["user_id", "story_id"], name: "index_saved_stories_on_user_id_and_story_id", unique: true
  end

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.bigint "user_id", null: false
    t.string "url", limit: 250, default: ""
    t.string "normalized_url"
    t.string "title", limit: 150, default: "", null: false
    t.text "description"
    t.string "short_id", limit: 6, default: "", null: false
    t.boolean "is_deleted", default: false, null: false
    t.integer "score", default: 1, null: false
    t.integer "flags", default: 0, null: false
    t.boolean "is_moderated", default: false, null: false
    t.decimal "hotness", precision: 20, scale: 10, default: "0.0", null: false
    t.text "markeddown_description"
    t.integer "comments_count", default: 0, null: false
    t.bigint "merged_story_id"
    t.datetime "unavailable_at", precision: nil
    t.string "twitter_id", limit: 20
    t.boolean "user_is_author", default: false
    t.boolean "user_is_following", default: false, null: false
    t.bigint "domain_id"
    t.index ["created_at"], name: "index_stories_on_created_at"
    t.index ["domain_id"], name: "index_stories_on_domain_id"
    t.index ["hotness"], name: "hotness_idx"
    t.index ["id", "is_deleted"], name: "index_stories_on_id_and_is_deleted"
    t.index ["merged_story_id"], name: "index_stories_on_merged_story_id"
    t.index ["normalized_url"], name: "index_stories_on_normalized_url"
    t.index ["score"], name: "index_stories_on_score"
    t.index ["short_id"], name: "unique_short_id", unique: true
    t.index ["twitter_id"], name: "index_stories_on_twitter_id"
    t.index ["url"], name: "url"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "story_texts", force: :cascade do |t|
    t.string "title", limit: 150, default: "", null: false
    t.text "description"
    t.text "body"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["title", "description", "body"], name: "index_story_texts_on_title_and_description_and_body"
    t.index ["title"], name: "index_story_texts_on_title"
  end

  create_table "suggested_taggings", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "tag_id", null: false
    t.bigint "user_id", null: false
    t.index ["story_id"], name: "suggested_taggings_story_id_fk"
    t.index ["tag_id"], name: "suggested_taggings_tag_id_fk"
    t.index ["user_id"], name: "suggested_taggings_user_id_fk"
  end

  create_table "suggested_titles", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "user_id", null: false
    t.string "title", limit: 150, default: "", null: false
    t.index ["story_id"], name: "suggested_titles_story_id_fk"
    t.index ["user_id"], name: "suggested_titles_user_id_fk"
  end

  create_table "tag_filters", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.bigint "tag_id", null: false
    t.index ["tag_id"], name: "tag_filters_tag_id_fk"
    t.index ["user_id", "tag_id"], name: "user_tag_idx"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "tag_id", null: false
    t.index ["story_id", "tag_id"], name: "story_id_tag_id", unique: true
    t.index ["tag_id"], name: "taggings_tag_id_fk"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag", limit: 25, null: false
    t.string "description", limit: 100
    t.boolean "privileged", default: false, null: false
    t.boolean "is_media", default: false, null: false
    t.boolean "active", default: true, null: false
    t.float "hotness_mod", default: 0.0
    t.boolean "permit_by_new_users", default: true, null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_tags_on_category_id"
    t.index ["tag"], name: "tag", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 50
    t.string "email", limit: 100
    t.datetime "created_at", precision: nil
    t.boolean "is_admin", default: false
    t.string "session_token", limit: 75, default: "", null: false
    t.text "about"
    t.bigint "invited_by_user_id"
    t.boolean "is_moderator", default: false
    t.boolean "pushover_mentions", default: false
    t.string "rss_token", limit: 75
    t.string "mailing_list_token", limit: 75
    t.integer "mailing_list_mode", default: 0
    t.integer "karma", default: 0, null: false
    t.datetime "banned_at", precision: nil
    t.bigint "banned_by_user_id"
    t.string "banned_reason", limit: 200
    t.datetime "deleted_at", precision: nil
    t.datetime "disabled_invite_at", precision: nil
    t.bigint "disabled_invite_by_user_id"
    t.string "disabled_invite_reason", limit: 200
    t.text "settings"
    t.boolean "show_email", default: false, null: false
    t.string "aqora_id", default: "0"
    t.index ["aqora_id"], name: "index_users_on_aqora_id", unique: true
    t.index ["banned_by_user_id"], name: "users_banned_by_user_id_fk"
    t.index ["disabled_invite_by_user_id"], name: "users_disabled_invite_by_user_id_fk"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invited_by_user_id"], name: "users_invited_by_user_id_fk"
    t.index ["mailing_list_mode"], name: "mailing_list_enabled"
    t.index ["mailing_list_token"], name: "mailing_list_token", unique: true
    t.index ["rss_token"], name: "rss_token", unique: true
    t.index ["session_token"], name: "session_hash", unique: true
    t.index ["username"], name: "username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.bigint "comment_id"
    t.integer "vote", limit: 2, null: false
    t.string "reason", limit: 1
    t.datetime "updated_at", precision: nil, null: false
    t.index ["comment_id"], name: "index_votes_on_comment_id"
    t.index ["story_id"], name: "votes_story_id_fk"
    t.index ["user_id", "comment_id"], name: "user_id_comment_id"
    t.index ["user_id", "story_id"], name: "user_id_story_id"
  end

  add_foreign_key "comments", "comments", column: "parent_comment_id", name: "comments_parent_comment_id_fk"
  add_foreign_key "comments", "hats", name: "comments_hat_id_fk"
  add_foreign_key "comments", "stories", name: "comments_story_id_fk"
  add_foreign_key "comments", "users", name: "comments_user_id_fk"
  add_foreign_key "hat_requests", "users", name: "hat_requests_user_id_fk"
  add_foreign_key "hats", "users", column: "granted_by_user_id", name: "hats_granted_by_user_id_fk"
  add_foreign_key "hats", "users", name: "hats_user_id_fk"
  add_foreign_key "hidden_stories", "stories", name: "hidden_stories_story_id_fk"
  add_foreign_key "hidden_stories", "users", name: "hidden_stories_user_id_fk"
  add_foreign_key "invitations", "users", column: "new_user_id", name: "invitations_new_user_id_fk"
  add_foreign_key "invitations", "users", name: "invitations_user_id_fk"
  add_foreign_key "messages", "hats", name: "messages_hat_id_fk"
  add_foreign_key "messages", "users", column: "recipient_user_id", name: "messages_recipient_user_id_fk"
  add_foreign_key "mod_notes", "users", column: "moderator_user_id", name: "mod_notes_moderator_user_id_fk"
  add_foreign_key "mod_notes", "users", name: "mod_notes_user_id_fk"
  add_foreign_key "moderations", "comments", name: "moderations_comment_id_fk"
  add_foreign_key "moderations", "stories", name: "moderations_story_id_fk"
  add_foreign_key "moderations", "tags", name: "moderations_tag_id_fk"
  add_foreign_key "moderations", "users", column: "moderator_user_id", name: "moderations_moderator_user_id_fk"
  add_foreign_key "read_ribbons", "stories", name: "read_ribbons_story_id_fk"
  add_foreign_key "read_ribbons", "users", name: "read_ribbons_user_id_fk"
  add_foreign_key "saved_stories", "stories", name: "saved_stories_story_id_fk"
  add_foreign_key "saved_stories", "users", name: "saved_stories_user_id_fk"
  add_foreign_key "stories", "domains"
  add_foreign_key "stories", "stories", column: "merged_story_id", name: "stories_merged_story_id_fk"
  add_foreign_key "stories", "users", name: "stories_user_id_fk"
  add_foreign_key "suggested_taggings", "stories", name: "suggested_taggings_story_id_fk"
  add_foreign_key "suggested_taggings", "tags", name: "suggested_taggings_tag_id_fk"
  add_foreign_key "suggested_taggings", "users", name: "suggested_taggings_user_id_fk"
  add_foreign_key "suggested_titles", "stories", name: "suggested_titles_story_id_fk"
  add_foreign_key "suggested_titles", "users", name: "suggested_titles_user_id_fk"
  add_foreign_key "tag_filters", "tags", name: "tag_filters_tag_id_fk"
  add_foreign_key "tag_filters", "users", name: "tag_filters_user_id_fk"
  add_foreign_key "taggings", "stories", name: "taggings_story_id_fk"
  add_foreign_key "taggings", "tags", name: "taggings_tag_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "users", column: "banned_by_user_id", name: "users_banned_by_user_id_fk"
  add_foreign_key "users", "users", column: "disabled_invite_by_user_id", name: "users_disabled_invite_by_user_id_fk"
  add_foreign_key "users", "users", column: "invited_by_user_id", name: "users_invited_by_user_id_fk"
  add_foreign_key "votes", "comments", name: "votes_comment_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "votes", "stories", name: "votes_story_id_fk"
  add_foreign_key "votes", "users", name: "votes_user_id_fk"

  create_view "replying_comments", sql_definition: <<-SQL
      SELECT read_ribbons.user_id,
      comments.id AS comment_id,
      read_ribbons.story_id,
      comments.parent_comment_id,
      comments.created_at AS comment_created_at,
      parent_comments.user_id AS parent_comment_author_id,
      comments.user_id AS comment_author_id,
      stories.user_id AS story_author_id,
      (read_ribbons.updated_at < comments.created_at) AS is_unread,
      ( SELECT votes.vote
             FROM votes
            WHERE ((votes.user_id = read_ribbons.user_id) AND (votes.comment_id = comments.id))) AS current_vote_vote,
      ( SELECT votes.reason
             FROM votes
            WHERE ((votes.user_id = read_ribbons.user_id) AND (votes.comment_id = comments.id))) AS current_vote_reason
     FROM (((read_ribbons
       JOIN comments ON ((comments.story_id = read_ribbons.story_id)))
       JOIN stories ON ((stories.id = comments.story_id)))
       LEFT JOIN comments parent_comments ON ((parent_comments.id = comments.parent_comment_id)))
    WHERE ((read_ribbons.is_following = true) AND (comments.user_id <> read_ribbons.user_id) AND (comments.is_deleted = false) AND (comments.is_moderated = false) AND ((parent_comments.user_id = read_ribbons.user_id) OR ((parent_comments.user_id IS NULL) AND (stories.user_id = read_ribbons.user_id))) AND (stories.score >= 0) AND (comments.score >= 0) AND ((parent_comments.id IS NULL) OR ((parent_comments.score >= 0) AND (parent_comments.is_moderated = false) AND (parent_comments.is_deleted = false))) AND ((EXISTS ( SELECT 1
             FROM (votes f
               JOIN comments c ON ((f.comment_id = c.id)))
            WHERE ((f.vote < 0) AND (f.user_id = parent_comments.user_id) AND (c.user_id = comments.user_id) AND (f.story_id = comments.story_id)))) IS FALSE));
  SQL
end
