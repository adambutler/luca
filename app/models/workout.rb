class Workout < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy

  default_scope { order(:scheduled_at) }
  scope :future, -> { where("scheduled_at >= ?", Time.zone.now) }

  broadcasts_refreshes

  def is_next?
    user.workouts.future.first == self
  end

  def self.primary_for_user(user)
    primary = user.workouts.future.first
    primary ||= user.workouts.last

    primary
  end

  def next_workout
    user.workouts.where("scheduled_at > ?", scheduled_at).first
  end
  
  def previous_workout
    user.workouts.where("scheduled_at < ?", scheduled_at).last
  end
end
