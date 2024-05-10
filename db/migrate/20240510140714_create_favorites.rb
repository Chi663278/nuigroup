class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id,              null: false
      t.boolean :is_active,            null: false, default: "TRUE"

      t.timestamps
    end
  end
end
