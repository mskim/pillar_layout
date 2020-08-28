class CreateTableStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :table_styles do |t|
      t.string :name
      t.integer :column
      t.integer :row
      t.integer :heading_level
      t.integer :category_level
      t.text :layout

      t.timestamps
    end
  end
end
