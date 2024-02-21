class Exercise < ApplicationRecord
  has_many :activities
  belongs_to :user, optional: true
  
  def self.suggested_exercises(user)
    Exercise.joins(activities: :workout)
      .where("workouts.user_id = ?", user.id)
      .group("exercises.id")
      .order("COUNT(exercises.id) DESC")
  end
  
  def import_to_typesense!
    Search::Exercise.import!(self)
  end  
end
