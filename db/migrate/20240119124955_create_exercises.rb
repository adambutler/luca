class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :description, null: false
      t.string :exercise_type, null: false, index: true
      t.string :body_part, null: false, index: true
      t.string :equipment, null: false, index: true
      t.string :level, null: false, index: true
      t.float :ranking, null: false, default: 0.0

      t.timestamps
    end
  end
end
