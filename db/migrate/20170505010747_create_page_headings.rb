class CreatePageHeadings < ActiveRecord::Migration[5.0]
  def change
    create_table :page_headings do |t|
      t.integer :page_number
      t.string :section_name
      t.string :date
      t.text :layout
      t.integer :page_id
      t.timestamps
    end
  end
end
