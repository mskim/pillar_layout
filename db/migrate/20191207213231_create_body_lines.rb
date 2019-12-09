class CreateBodyLines < ActiveRecord::Migration[6.0]
  def change
    create_table :body_lines do |t|
      t.integer :order
      t.float :x
      t.float :y
      t.float :width
      t.float :height
      t.integer :coulumn
      t.integer :line_number
      t.text :tokens
      t.integer :kind # text, covered, partially_covered
      t.references :working_article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
