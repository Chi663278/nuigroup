class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,              null: false
      t.text :caption,                              default: ""
      t.boolean :is_active,            null: false, default: "TRUE"

      t.timestamps
    end
  end
end
