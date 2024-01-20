class CreateActivitySets < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_sets do |t|
      t.references :activity, null: false, foreign_key: true
      t.float :load_goal, null: false
      t.float :load_actual
      t.int4range :repetitions_goal, null: false
      t.string :repetitions_actual
      t.string :repetitions_type, null: false
      t.boolean :warmup, null: false, default: false

      t.timestamps
    end
  end
end
