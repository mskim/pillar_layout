class RemoveSubGridSizeFromImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :sub_grid_size, :string
  end
end
