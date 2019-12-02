class AddXGridToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :x_grid, :integer
    add_column :images, :y_in_lines, :integer
    add_column :images, :height_in_lines, :integer
    add_column :images, :detail_mode, :boolean
    add_column :images, :draw_frame, :boolean, default: true
    add_column :images, :zoom_level, :integer, default: 1
    add_column :images, :zoom_direction, :integer, default: 5
    add_column :images, :move_level, :integer    
    add_column :images, :sub_grid_size, :string
  end
end
