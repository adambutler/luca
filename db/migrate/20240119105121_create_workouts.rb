class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :scheduled_at, null: false, index: true

      t.timestamps
    end
  end
end
