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

ActiveRecord::Schema.define(version: 20170711112735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "statement"
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "batch_set_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "remark_id"
    t.string   "is_correct"
    t.float    "score"
  end

  create_table "batch_events", force: :cascade do |t|
    t.integer  "batch_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batch_set_chapter_topics", force: :cascade do |t|
    t.integer  "batch_set_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "chapter_id"
    t.integer  "topic_id"
  end

  create_table "batch_set_questions", force: :cascade do |t|
    t.integer  "batch_set_id"
    t.integer  "question_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "batch_sets", force: :cascade do |t|
    t.date     "set_date"
    t.integer  "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "kind"
    t.datetime "due_date"
  end

  create_table "batch_students", force: :cascade do |t|
    t.integer  "batch_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batches", force: :cascade do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "course_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "complete",   default: false
  end

  create_table "chapter_topics", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "short_name"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "statement"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_topics", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "due_date_lists", force: :cascade do |t|
    t.integer  "batch_set_id"
    t.jsonb    "user_ids",      default: [],              array: true
    t.datetime "due_date_time"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "event_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "knowledge_bases", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "is_private",   default: false
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.boolean  "published",    default: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "links"
    t.string   "article_code"
  end

  create_table "options", force: :cascade do |t|
    t.text     "statement"
    t.boolean  "is_answer",   default: false
    t.integer  "question_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "question_set_chapter_topics", force: :cascade do |t|
    t.integer  "question_set_id"
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "question_sets", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "batch_set_id"
    t.jsonb    "question_ids",     default: [],              array: true
    t.jsonb    "user_ids",         default: [],              array: true
    t.string   "difficulty_level"
  end

  create_table "question_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "statement"
    t.integer  "question_type_id"
    t.integer  "answer_option_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "topic_id"
    t.integer  "chapter_id"
    t.string   "kind"
    t.string   "code"
    t.string   "title"
    t.string   "difficulty_level"
    t.jsonb    "tag_ids",          default: [],              array: true
  end

  create_table "remarks", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solutions", force: :cascade do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "topic_id"
    t.integer  "chapter_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "gender"
    t.date     "dob"
    t.string   "difficulty_level", default: "easy"
    t.boolean  "is_active",        default: true
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "question_ids", default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "short_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "student_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "role",                   default: "student"
    t.boolean  "is_active",              default: true
    t.string   "name"
    t.string   "avatar"
    t.string   "gender"
    t.date     "dob"
    t.string   "mobile"
    t.string   "difficulty_level"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "youtube_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
