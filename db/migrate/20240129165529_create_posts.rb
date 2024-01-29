class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.integer :post_type, null: false, default: 0
      t.text :body, null: false
      t.references :subject, polymorphic: true, null: false

      t.timestamps
    end
  end
end
