require "csv"

if Exercise.count > 0
  puts "Skipping db:load_exercises because exercises already exist."
else
  puts "Loading exercises from db/exercises.yml"
  CSV.foreach(Rails.root.join("config", "fixtures", "exercises.csv"), headers: true) do |row|
    Exercise.create!(row.to_h)
  end
end

user = User.create!(email: "adam@labfoo.dev", password: "Password1!")

workouts = [
  Workout.create!(user: user, scheduled_at: Time.parse("2024-01-15 14:00")),
  Workout.create!(user: user, scheduled_at: Time.parse("2024-01-18 18:00")),
  Workout.create!(user: user, scheduled_at: Time.parse("2024-01-19 14:30")),
  Workout.create!(user: user, scheduled_at: Time.parse("2024-01-22 14:00")),
  Workout.create!(user: user, scheduled_at: Time.parse("2024-01-26 18:00"))
]

workout = workouts.first

activity = workout.activities.create!(workout: workout, exercise: exercise)
exercise = Exercise.find_by!(title: "Romanian Deadlift")

activity.sets.create!({
  load_goal: 20,
  repetitions_goal: 4..6,
  repetitions_type: "range",
  warmup: true
})

activity.sets.create!({
  load_goal: 40,
  repetitions_goal: 8..10,
  repetitions_type: "range",
  warmup: false
})

activity.sets.create!({
  load_goal: 45,
  repetitions_goal: 8..10,
  repetitions_type: "range",
  warmup: false
})

activity.sets.create!({
  load_goal: 45,
  repetitions_goal: 8..10,
  repetitions_type: "range",
  warmup: false
})

exercise = Exercise.find_by!(title: "Barbell Squat")
activity = workout.activities.create!(workout: workout, exercise: exercise)

activity.sets.create!({
  load_goal: 20,
  repetitions_goal: 4..6,
  repetitions_type: "range",
  warmup: true
})

activity.sets.create!({
  load_goal: 50,
  repetitions_goal: 7..7,
  repetitions_type: "limit",
  warmup: false
})

activity.sets.create!({
  load_goal: 55,
  repetitions_goal: 7..7,
  repetitions_type: "limit",
  warmup: false
})

activity.sets.create!({
  load_goal: 55,
  repetitions_goal: 7..7,
  repetitions_type: "limit",
  warmup: false
})
