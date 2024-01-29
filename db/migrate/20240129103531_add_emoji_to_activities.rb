class AddEmojiToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :emoji, :integer, default: 0, null: false
    add_index :activities, :emoji
  end
end
