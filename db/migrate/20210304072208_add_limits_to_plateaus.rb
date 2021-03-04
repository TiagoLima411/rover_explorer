class AddLimitsToPlateaus < ActiveRecord::Migration[5.2]
  def change
    add_column :plateaus, :limit_y, :integer, after: :size
    add_column :plateaus, :limit_x, :integer, after: :size
  end
end
