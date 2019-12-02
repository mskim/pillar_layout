class CreateYhGraphics < ActiveRecord::Migration[5.2]
  def change
    create_table :yh_graphics do |t|
      t.string :action
      t.string :service_type
      t.string :content_id
      t.date :date
      t.time :time
      t.string :urgency
      t.string :category
      t.string :class_code
      t.string :attriubute_code
      t.string :source
      t.string :credit
      t.string :region
      t.string :title
      t.string :comment
      t.string :body
      t.string :picture
      t.string :taken_by

      t.timestamps
    end
  end
end
