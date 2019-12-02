class CreateWorkingArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :working_articles do |t|
      t.integer :grid_x
      t.integer :grid_y
      t.integer :column
      t.integer :row
      t.integer :order
      t.string :kind
      t.string :profile
      t.text :title
      t.string :title_head
      t.text :subtitle
      t.string :subtitle_head
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
      t.boolean :inactive
      t.integer :extended_line_count
      t.integer :pushed_line_count
      t.references :article
      t.references :page
      # t.references :article, foreign_key: true
      # t.references :page, foreign_key: true
      #
      t.timestamps
    end
  end
end
