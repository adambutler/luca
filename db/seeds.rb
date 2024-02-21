require "csv"

if Exercise.count > 0
  puts "Skipping db:load_exercises because exercises already exist."
else
  puts "Loading exercises from db/exercises.yml"
  CSV.foreach(Rails.root.join("config", "fixtures", "exercises.csv"), headers: true) do |row|
    Exercise.create!(row.to_h)
  end
end

user = FactoryBot.create(:user, email: "adam@labfoo.dev")
workouts = FactoryBot.create_list(:workout, 2, user: user)
first_workout = workouts.first

exercise = Exercise.find_by!(title: "Romanian Deadlift")
activity = FactoryBot.create(:activity, :good, workout: first_workout, exercise: exercise)
FactoryBot.create_list(:activity_set, 3, :complete, activity: activity)

exercise = Exercise.find_by!(title: "Barbell Squat")
activity = FactoryBot.create(:activity, :good, workout: first_workout, exercise: exercise)
FactoryBot.create_list(:activity_set, 3, :complete, activity: activity)

Search::Exercise.destroy_typesense_schema!
Search::Exercise.create_typesense_schema!
Exercise.all.each(&:import_to_typesense!)
