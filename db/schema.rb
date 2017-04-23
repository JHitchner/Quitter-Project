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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170422172445) do
=======
ActiveRecord::Schema.define(version: 20170422211110) do
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d

  create_table "posts", force: :cascade do |t|
    t.string  "post_title"
    t.string  "post_body"
<<<<<<< HEAD
    t.integer "profile_id"
=======
>>>>>>> 4c945d999e815021d47ee6540866895ea52a495d
    t.integer "user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "bday"
    t.text     "bio"
    t.string   "profile_img"
    t.integer  "user_id"
    t.integer  "post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "password"
    t.integer "profile_id"
  end

end
