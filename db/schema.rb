# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100620133744) do

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "user_id"
    t.string   "tweet_id"
    t.datetime "tweet_created_at"
    t.text     "tweet_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tweet_user_name"
    t.string   "tweet_user_screen_name"
    t.string   "tweet_user_profile_image_url"
    t.integer  "taggings_count",               :default => 0
  end

  add_index "tweets", ["tweet_id"], :name => "index_tweets_on_tweet_id"
  add_index "tweets", ["user_id"], :name => "index_tweets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_id"
  end

  add_index "users", ["screen_name"], :name => "index_users_on_screen_name"
  add_index "users", ["twitter_id"], :name => "index_users_on_twitter_id"

end
