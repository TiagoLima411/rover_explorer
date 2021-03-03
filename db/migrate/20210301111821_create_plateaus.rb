class CreatePlateaus < ActiveRecord::Migration[5.2]
  def change
    create_table :plateaus do |t|
      t.string :size, null: false

      t.timestamps
    end
  end
end
