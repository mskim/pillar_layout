class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :profile
      t.integer :column
      t.integer :row
      t.integer :order
      t.string :ad_type
      t.boolean :is_front_page
      t.integer :story_count
      t.integer :page_number
      t.string :section_name
      t.boolean :color_page, :default=> false
      t.integer :publication_id, :default => 1
      t.text :layout

      t.timestamps
    end
  end
end
