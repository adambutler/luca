require "csv"
require "rake"

namespace :db do
  desc "Loads the data from the CSV file into the Exercise model"
  task load_exercises: :environment do
    CSV.foreach(Rails.root.join("config", "fixtures", "exercises.csv"), headers: true) do |row|
      Exercise.create!(row.to_h)
    end
  end
end
