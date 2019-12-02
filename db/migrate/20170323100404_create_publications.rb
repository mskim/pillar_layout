class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.string :name
      t.string :unit
      t.string :paper_size
      t.float :width_in_unit
      t.float :height_in_unit
      t.float :left_margin_in_unit
      t.float :top_margin_in_unit
      t.float :right_margin_in_unit
      t.float :bottom_margin_in_unit
      t.float :gutter_in_unit
      t.float :width
      t.float :height
      t.float :left_margin
      t.float :top_margin
      t.float :right_margin
      t.float :bottom_margin
      t.float :gutter
      t.integer :lines_per_grid
      t.integer :page_count
      t.text :section_names
      t.text :page_columns
      t.integer :row
      t.integer :front_page_heading_height
      t.integer :inner_page_heading_height
      t.integer :article_bottom_spaces_in_lines
      t.text :article_line_draw_sides
      t.float :article_line_thickness
      t.boolean :draw_divider
      t.string :cms_server_url
      t.timestamps
    end
  end
end
