class Activity < ApplicationRecord
  enum :emoji, %i[default great strong good bad hard medium pain injury skip replaced]
  
  belongs_to :workout, touch: true
  belongs_to :exercise
  has_many :sets, dependent: :destroy, class_name: "ActivitySet"
  has_many :comments, dependent: :destroy, class_name: "Post", as: :subject

  default_scope { order(:created_at) }

  def has_warmup?
    sets.warmup.any?
  end

  def display_title
    exercise.title
  end

  def previous
    @previous ||= Activity
      .joins(:workout)
      .where(exercise: exercise, workout: { user: workout.user })
      .where("workout.scheduled_at < ?", workout.scheduled_at)
      .order("workout.scheduled_at ASC")
      .last
  end
end
