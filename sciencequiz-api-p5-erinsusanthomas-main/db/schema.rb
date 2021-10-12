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

ActiveRecord::Schema.define(version: 2021_03_21_233552) do

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.integer "organization_id"
    t.boolean "active", default: true
    t.index ["organization_id"], name: "index_events_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "short_name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "event_id"
    t.string "division"
    t.integer "room"
    t.integer "round"
    t.index ["event_id"], name: "index_quizzes_on_event_id"
  end

  create_table "student_quizzes", force: :cascade do |t|
    t.integer "student_id"
    t.integer "quiz_id"
    t.integer "score"
    t.integer "num_attempted"
    t.integer "num_correct"
    t.index ["quiz_id"], name: "index_student_quizzes_on_quiz_id"
    t.index ["student_id"], name: "index_student_quizzes_on_student_id"
  end

  create_table "student_teams", force: :cascade do |t|
    t.integer "student_id"
    t.integer "team_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "position"
    t.boolean "active", default: true
    t.index ["student_id"], name: "index_student_teams_on_student_id"
    t.index ["team_id"], name: "index_student_teams_on_team_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "grade"
    t.integer "organization_id"
    t.boolean "active", default: true
    t.index ["organization_id"], name: "index_students_on_organization_id"
  end

  create_table "team_quizzes", force: :cascade do |t|
    t.integer "team_id"
    t.integer "quiz_id"
    t.integer "raw_score"
    t.integer "team_points"
    t.integer "position"
    t.index ["quiz_id"], name: "index_team_quizzes_on_quiz_id"
    t.index ["team_id"], name: "index_team_quizzes_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "organization_id"
    t.string "division"
    t.boolean "active", default: true
    t.integer "coach_id"
    t.index ["organization_id"], name: "index_teams_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.integer "organization_id"
    t.boolean "active", default: true
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "username"
    t.datetime "active_after"
    t.string "reset_token"
    t.datetime "reset_sent_at"
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

end
