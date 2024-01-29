class Activity < ApplicationRecord
  enum :emoji, %i[default great strong good bad hard medium pain injury skip replaced]
  
  belongs_to :workout, touch: true
  belongs_to :exercise
  has_many :sets, dependent: :destroy, class_name: "ActivitySet"

  default_scope { order(:created_at) }

  def has_warmup?
    sets.warmup.any?
  end
end
