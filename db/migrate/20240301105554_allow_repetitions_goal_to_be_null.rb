class AllowRepetitionsGoalToBeNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :activity_sets, :repetitions_goal, true
    change_column_null :activity_sets, :repetitions_type, true
  end
end
