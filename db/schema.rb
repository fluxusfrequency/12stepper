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

ActiveRecord::Schema.define(version: 20140224210832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "big_book_chapter_translations", force: true do |t|
    t.integer  "big_book_chapter_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
  end

  add_index "big_book_chapter_translations", ["big_book_chapter_id"], name: "index_big_book_chapter_translations_on_big_book_chapter_id", using: :btree
  add_index "big_book_chapter_translations", ["locale"], name: "index_big_book_chapter_translations_on_locale", using: :btree

  create_table "big_book_chapters", force: true do |t|
    t.string  "title"
    t.text    "body"
    t.integer "chapter_number"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "entries", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "step"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "section"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_drink"
  end

  create_table "worksheet_translations", force: true do |t|
    t.integer  "worksheet_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
  end

  add_index "worksheet_translations", ["locale"], name: "index_worksheet_translations_on_locale", using: :btree
  add_index "worksheet_translations", ["worksheet_id"], name: "index_worksheet_translations_on_worksheet_id", using: :btree

  create_table "worksheets", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "locale"
    t.integer  "step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
