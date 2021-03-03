class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.references :rover, foreign_key: true
      t.integer :x, null: false
      t.integer :y, null: false
      t.string :orientation, null: false

      t.timestamps
    end
  end
end
