class CreateWebPages < ActiveRecord::Migration[6.0]
  def change
    create_table :web_pages do |t|
      t.string :current_tool
      t.decimal :width
      t.decimal :height
      t.integer :page_number
      t.boolean :toc
      t.text :text_content
      t.integer :text_position
      t.references :issue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
