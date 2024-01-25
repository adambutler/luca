class CreateClientMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :client_memberships do |t|
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :trainer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
