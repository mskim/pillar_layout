class AddPathToSection < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :path, :string
    add_column :sections, :grid_width, :float
    add_column :sections, :grid_height, :float
    add_column :sections, :lines_per_grid, :float
    add_column :sections, :width, :float
    add_column :sections, :height, :float
    add_column :sections, :left_margin, :float
    add_column :sections, :top_margin, :float
    add_column :sections, :right_margin, :float
    add_column :sections, :bottom_margin, :float
    add_column :sections, :gutter, :float
    add_column :sections, :page_heading_margin_in_lines, :integer
    add_column :sections, :article_line_thickness, :float
    
  end
end
