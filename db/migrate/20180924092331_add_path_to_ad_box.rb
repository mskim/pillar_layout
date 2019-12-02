class AddPathToAdBox < ActiveRecord::Migration[5.2]
  def change
    add_column :ad_boxes, :path, :string
    add_column :ad_boxes, :date, :date
    add_column :ad_boxes, :page_heading_margin_in_lines, :integer
    add_column :ad_boxes, :page_number, :integer
    add_column :ad_boxes, :grid_width, :float
    add_column :ad_boxes, :grid_height, :float
    add_column :ad_boxes, :gutter, :float
  end
end
