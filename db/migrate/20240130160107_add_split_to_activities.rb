class AddSplitToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :split, :boolean, default: false, null: false
  end
end
