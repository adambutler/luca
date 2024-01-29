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

ActiveRecord::Schema[7.1].define(version: 2024_01_29_165529) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "emoji", default: 0, null: false
    t.index ["emoji"], name: "index_activities_on_emoji"
    t.index ["exercise_id"], name: "index_activities_on_exercise_id"
    t.index ["workout_id"], name: "index_activities_on_workout_id"
  end

  create_table "activity_sets", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.float "load_goal", null: false
    t.float "load_actual"
    t.int4range "repetitions_goal", null: false
    t.string "repetitions_actual"
    t.string "repetitions_type", null: false
    t.boolean "warmup", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_sets_on_activity_id"
  end

  create_table "client_memberships", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_memberships_on_client_id"
    t.index ["trainer_id"], name: "index_client_memberships_on_trainer_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "exercise_type", null: false
    t.string "body_part", null: false
    t.string "equipment", null: false
    t.string "level", null: false
    t.float "ranking", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_part"], name: "index_exercises_on_body_part"
    t.index ["equipment"], name: "index_exercises_on_equipment"
    t.index ["exercise_type"], name: "index_exercises_on_exercise_type"
    t.index ["level"], name: "index_exercises_on_level"
    t.index ["title"], name: "index_exercises_on_title", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.integer "post_type", default: 0, null: false
    t.text "body", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_type", "subject_id"], name: "index_posts_on_subject"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scheduled_at"], name: "index_workouts_on_scheduled_at"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "activities", "exercises"
  add_foreign_key "activities", "workouts"
  add_foreign_key "activity_sets", "activities"
  add_foreign_key "client_memberships", "users", column: "client_id"
  add_foreign_key "client_memberships", "users", column: "trainer_id"
  add_foreign_key "workouts", "users"
end
