class CreateSpreads < ActiveRecord::Migration[5.2]
  def change
    create_table :spreads do |t|
      t.references :issue, foreign_key: true
      t.integer :left_page_id
      t.integer :right_page_id
      t.integer :ad_box_id
      t.boolean :color_page
      t.float :width
      t.float :height
      t.float :left_margin
      t.float :top_margin
      t.float :right_margin
      t.float :bottom_margin
      t.float :page_gutter

      t.timestamps
    end
  end
end
