class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.references :user, foreign_key: true
      t.references :working_article, foreign_key: true
      t.date :date
      t.string :reporter
      t.string :group
      t.string :title
      t.string :subtitle
      t.string :quote
      t.string :body
      t.integer :char_count
      t.string :status
      t.boolean :for_front_page
      t.boolean :summitted
      t.boolean :selected
      t.boolean :published
      t.time :summitted_at
      t.string :path
      t.integer :order
      t.string :image_name

      t.timestamps
    end
  end
end
