class CreatePillars < ActiveRecord::Migration[5.2]
  def change
    create_table :pillars do |t|
      t.string :direction
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.integer :order
      t.integer :box_count
      t.text :layout_with_pillar_path
      t.text :layout
      t.string :profile
      t.string :finger_print
      t.references :region, polymophic: true
      t.string :region_type

      t.timestamps
    end
  end
end
