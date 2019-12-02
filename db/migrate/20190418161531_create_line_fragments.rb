class CreateLineFragments < ActiveRecord::Migration[5.2]
  def change
    create_table :line_fragments do |t|
      t.references :working_article, foreign_key: true
      t.references :paragraph, foreign_key: true
      t.integer :order
      t.integer :column
      t.string :line_type
      t.float :x
      t.float :y
      t.float :width
      t.float :height
      t.text :tokens
      t.float :text_area_x
      t.float :text_area_width

      t.timestamps
    end
  end
end
