class CreateAdBoxTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_box_templates do |t|
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.integer :order
      t.string :ad_type
      t.integer :section_id

      t.timestamps
    end
  end
end
