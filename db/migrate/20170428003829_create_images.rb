class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :column
      t.integer :row
      t.integer :extra_height_in_lines, default: 0
      t.string :image
      t.string :caption_title
      t.string :caption
      t.string :source
      t.integer :position
      t.integer :page_number
      t.integer :story_number
      t.boolean :landscape
      t.boolean :used_in_layout
      t.integer :working_article_id
      t.integer :issue_id

      t.timestamps
    end
  end
end
