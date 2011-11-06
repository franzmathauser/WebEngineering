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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111102230812) do

  create_table "audios", :force => true do |t|
    t.string   "filehash"
    t.boolean  "converted"
    t.boolean  "imageprocessed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "song_comments", :force => true do |t|
    t.float    "from_duration"
    t.float    "to_duration"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "song_comments", ["song_id"], :name => "index_song_comments_on_song_id"
  add_index "song_comments", ["user_id"], :name => "index_song_comments_on_user_id"

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.integer  "duration"
    t.integer  "audio_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
