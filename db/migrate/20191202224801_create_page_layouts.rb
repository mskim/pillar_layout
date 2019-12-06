class CreatePageLayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :page_layouts do |t|
      t.float :doc_width
      t.float :doc_height
      t.string :ad_type
      t.integer :page_type
      t.integer :column
      t.integer :row
      t.integer :pillar_count
      t.float :grid_width
      t.float :grid_height
      t.float :gutter
      t.float :margin
      t.text :layout
      t.text :layout_with_pillar_path
      t.integer :like

      t.timestamps
    end
  end
end
