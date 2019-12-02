class CreateGraphics < ActiveRecord::Migration[5.2]
  def change
    create_table :graphics do |t|
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.integer :extra_height_in_lines
      t.string :graphic
      t.string :caption
      t.string :source
      t.string :position
      t.integer :page_number
      t.integer :story_number
      t.references :working_article, foreign_key: true
      t.integer :issue_id

      t.timestamps
    end
  end
end
