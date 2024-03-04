class Exercise < ApplicationRecord
  has_many :activities
  belongs_to :user, optional: true

  def self.suggested_exercises(workout:)
    Exercise.joins(activities: :workout)
      .where("workouts.user_id = ?", workout.user.id)
      .where.not(id: workout.activities.pluck(:exercise_id))
      .group("exercises.id")
      .order("COUNT(exercises.id) DESC")
  end

  def import_to_typesense!
    Search::Exercise.import!(self)
  end

  def delete_from_typesense!
    Search::Exercise.delete!(self)
  end
end
