class CreateLayoutNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :layout_nodes do |t|
      t.string :direction
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.string :profile
      t.string :node_kind
      t.string :tag
      t.boolean :selected
      t.text :actions
      t.text :layout
      t.text :layout_with_pillar_path
      t.integer :box_count

      t.timestamps
    end
  end
end
