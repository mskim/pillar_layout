class CreateYhArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :yh_articles do |t|
      t.string :action
      t.string :service_type
      t.string :content_id
      t.date :date
      t.string :time
      t.string :urgency
      t.string :category
      t.string :class_code
      t.string :attriubute_code
      t.string :source
      t.string :credit
      t.string :page_ref
      t.string :title
      t.text :body
      t.string :writer
      t.integer :char_count
      t.string :taken_by

      t.timestamps
    end
  end
end
