class CreateWireStories < ActiveRecord::Migration[5.1]
  def change
    create_table :wire_stories do |t|
      t.date :send_date
      t.string :content_id
      t.string :category_code
      t.string :category_name
      t.string :page_ref_code
      t.string :page_ref_name
      t.string :credit
      t.string :source
      t.string :title
      t.text :body
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end
