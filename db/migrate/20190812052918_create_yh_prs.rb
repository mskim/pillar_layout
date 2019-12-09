class CreateYhPrs < ActiveRecord::Migration[5.2]
  def change
    create_table :yh_prs do |t|
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
      t.string :page_ref
      t.string :title
      t.string :comment
      t.string :body
      t.string :appenddata
      t.string :taken_by

      t.timestamps
    end
  end
end
