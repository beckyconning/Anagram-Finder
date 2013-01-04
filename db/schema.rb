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

ActiveRecord::Schema.define(:version => 20110805061139) do

  create_table "active_record_nodes", :force => true do |t|
    t.boolean "is_leaf"
    t.string  "key"
    t.integer "left"
    t.integer "right"
    t.integer "depth"
    t.integer "dictionary_id"
  end

  create_table "dictionaries", :force => true do |t|
  end

  create_table "linear_dictionaries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", :force => true do |t|
    t.string   "value"
    t.integer  "linear_dictionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
