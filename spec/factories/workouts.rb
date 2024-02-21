FactoryBot.define do
  factory :workout do
    user
    sequence(:scheduled_at) { |n| Time.current + 2 * n.days }
  end
end
