class Activity < ApplicationRecord
  belongs_to :workout, touch: true
  belongs_to :exercise
  has_many :sets, dependent: :destroy, class_name: "ActivitySet"

  default_scope { order(:created_at) }
end
