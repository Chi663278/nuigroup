class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :post_id,              null: false
      t.integer :user_id,              null: false
      t.text :comment,                 null: false, default: ""
      t.boolean :is_active,            null: false, default: "TRUE"

      t.timestamps
    end
  end
end
