FactoryBot.define do
  factory :activity_set do
    load_goal { 20 }
    repetitions_goal { 4..6 }
    repetitions_type { "range" }
    warmup { false }

    trait :complete do
      load_actual { 20 }
      repetitions_actual { 6 }
    end

    trait :warmup do
      warmup { true }
    end
  end
end
