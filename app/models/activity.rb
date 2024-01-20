class Activity < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :sets, dependent: :destroy, class_name: "ActivitySet"
end
