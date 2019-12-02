class CreateSectionHeadings < ActiveRecord::Migration[5.1]
  def change
    create_table :section_headings do |t|
      t.integer :page_number
      t.string :section_name
      t.string :date
      t.text :layout
      t.integer :publication_id

      t.timestamps
    end
  end
end
