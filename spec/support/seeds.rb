require 'csv'

RSpec.configure do |config|
  config.before(:suite) do
    puts "Seeding exercises..."
    puts "Exercise count: #{Exercise.count}"
    
    begin
      Exercise.destroy_typesense_schema!
    rescue Typesense::Error::ObjectNotFound
      puts "No typesense schema to destroy"
    end

    Exercise.create_typesense_schema!
    CSV.foreach(Rails.root.join("config", "fixtures", "exercises_test.csv"), headers: true) do |row|
      exercise = Exercise.create!(row.to_h)
      exercise.import_to_typesense!
    end

    puts "Completed seeding exercises. Total count: #{Exercise.count}"
  end
end
