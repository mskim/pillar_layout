class AddXGridToGraphic < ActiveRecord::Migration[5.2]
  def change
    add_column :graphics, :x_grid, :integer
    add_column :graphics, :y_in_lines, :integer
    add_column :graphics, :height_in_lines, :integer
    add_column :graphics, :draw_frame, :boolean, default: false
    add_column :graphics, :detail_mode, :boolean
    add_column :graphics, :zoom_level, :integer
    add_column :graphics, :zoom_direction, :integer
    add_column :graphics, :move_level, :integer    
    add_column :graphics, :sub_grid_size, :string
  end
end
