class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.integer :column
      t.integer :row
      t.integer :page_columns
      t.integer :publication_id

      t.timestamps
    end
  end
end
