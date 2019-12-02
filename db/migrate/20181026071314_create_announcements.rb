class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :name
      t.string :kind
      t.string :title
      t.string :subtitle
      t.integer :page_column
      t.integer :column
      t.integer :lines
      t.integer :page
      t.string :color
      t.text :script
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
