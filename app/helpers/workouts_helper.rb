module WorkoutsHelper
  def next_workout_link(workout)
    if workout.next_workout
      workout_path(workout.next_workout)
    end
  end

  def previous_workout_link(workout)
    if workout.previous_workout
      workout_path(workout.previous_workout)
    end
  end
end
