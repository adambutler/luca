FactoryBot.define do
  factory :activity do
    workout
    exercise { Exercise.all.sample }

    trait :good do
      emoji { :good }
    end
  end
end
