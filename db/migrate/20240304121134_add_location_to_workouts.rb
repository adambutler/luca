class AddLocationToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_column :workouts, :location, :string
    add_index :workouts, :location
  end
end
