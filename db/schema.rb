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

ActiveRecord::Schema[7.1].define(version: 2024_02_16_160518) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "emoji", default: 0, null: false
    t.boolean "split", default: false, null: false
  end

  create_table "activity_sets", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.float "load_goal", null: false
    t.float "load_actual"
    t.int4range "repetitions_goal", null: false
    t.string "repetitions_actual"
    t.string "repetitions_type", null: false
    t.boolean "warmup", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "client_memberships", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "exercise_type", null: false
    t.string "body_part", null: false
    t.string "equipment", null: false
    t.string "level", null: false
    t.float "ranking", default: 0.0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "post_type", default: 0, null: false
    t.text "body", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "author_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "scheduled_at", precision: nil, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "activities", "exercises", name: "activities_exercise_id_fkey"
  add_foreign_key "activities", "workouts", name: "activities_workout_id_fkey"
  add_foreign_key "activity_sets", "activities", name: "activity_sets_activity_id_fkey"
  add_foreign_key "client_memberships", "users", column: "client_id", name: "client_memberships_client_id_fkey"
  add_foreign_key "client_memberships", "users", column: "trainer_id", name: "client_memberships_trainer_id_fkey"
  add_foreign_key "exercises", "users"
  add_foreign_key "posts", "users", column: "author_id", name: "posts_author_id_fkey"
  add_foreign_key "workouts", "users", name: "workouts_user_id_fkey"
end
