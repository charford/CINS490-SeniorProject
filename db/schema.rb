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

ActiveRecord::Schema.define(:version => 20120427031243) do

  create_table "activeusers", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "additional_facts", :force => true do |t|
    t.integer  "evaluator_id"
    t.integer  "applicant_id"
    t.string   "fact"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "administrators", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "applicant_id"
    t.text     "body"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
  end

  create_table "applicants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.decimal  "avgrating",  :precision => 8, :scale => 2
    t.boolean  "published"
  end

  create_table "confirmations", :force => true do |t|
    t.integer  "user_id"
    t.string   "confirm_hash"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "evaluators", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hiring_managers", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobapps", :force => true do |t|
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "intro"
    t.boolean  "published"
  end

  create_table "jobs", :force => true do |t|
    t.text     "description"
    t.text     "minimum_qualifications"
    t.integer  "hiring_manager_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "position"
    t.text     "preferred_qualifications"
    t.text     "responsibilities"
    t.text     "salary"
    t.text     "department"
    t.boolean  "published"
  end

  create_table "questions", :force => true do |t|
    t.integer  "job_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "qtype"
    t.integer  "jobapp_id"
    t.string   "choice_a"
    t.string   "choice_b"
    t.string   "choice_c"
    t.string   "choice_d"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "applicant_id"
    t.integer  "evaluator_id", :limit => 255
    t.integer  "rating"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "comment"
  end

  create_table "references", :force => true do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.text     "letter"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "reference_hash"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
  end

  create_table "reset_requests", :force => true do |t|
    t.integer  "user_id"
    t.string   "request_hash"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "reference_hash"
    t.string   "address"
    t.string   "phone"
  end

end
