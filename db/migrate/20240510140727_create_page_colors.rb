class CreatePageColors < ActiveRecord::Migration[6.1]
  def change
    create_table :page_colors do |t|
      t.string :background_color,              null: false, default: "#E6D0DE"
      t.string :main_color,                    null: false, default: "#8A456C"
      t.string :button_color,                  null: false, default: "#C77B9F"

      t.timestamps
    end
  end
end
