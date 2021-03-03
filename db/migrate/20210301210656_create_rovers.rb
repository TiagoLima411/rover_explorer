class CreateRovers < ActiveRecord::Migration[5.2]
  def change
    create_table :rovers do |t|
      t.references :plateau, foreign_key: true
      t.string :position, null: false
      t.string :comand, null: false

      t.timestamps
    end
  end
end
