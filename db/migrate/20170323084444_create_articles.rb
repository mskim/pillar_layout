class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.integer :order
      t.string :kind
      t.integer :profile
      t.string :title_head
      t.text :title
      t.text :subtitle
      t.text :subtitle_head
      t.text :body
      t.string :reporter
      t.string :email
      t.string :personal_image
      t.string :image
      t.text :quote
      t.string :subject_head
      t.boolean :on_left_edge
      t.boolean :on_right_edge
      t.boolean :is_front_page
      t.boolean :top_story
      t.boolean :top_position
      t.integer :section_id
      t.timestamps
    end
  end
end
