class CreateTextStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :text_styles do |t|
      t.string :korean_name
      t.string :english
      t.string :category    #heaind, float, body
      t.string :font_family
      t.string :font
      t.float :font_size
      t.string :text_color
      t.string :alignment
      t.float :tracking
      t.float :space_width
      t.float :scale
      t.float :text_line_spacing
      t.integer :space_before_in_lines
      t.integer :space_after_in_lines
      t.integer :text_height_in_lines
      t.text :box_attributes
      t.string :markup
      t.text :graphic_attributes
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
