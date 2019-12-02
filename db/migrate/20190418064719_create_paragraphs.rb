class CreateParagraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :paragraphs do |t|
      t.string :name
      t.references :working_article, foreign_key: true
      t.integer :order
      t.text :para_text
      t.text :tokens

      t.timestamps
    end
  end
end
