class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.integer :column
      t.integer :row
      t.integer :extended_line_count
      t.text :body
      t.string :title
      t.string :source
      t.references :working_article, null: false, foreign_key: true
      t.integer :table_style_id

      t.timestamps
    end
  end
end
