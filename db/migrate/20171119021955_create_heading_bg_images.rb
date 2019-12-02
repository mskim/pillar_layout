class CreateHeadingBgImages < ActiveRecord::Migration[5.1]
  def change
    create_table :heading_bg_images do |t|
      t.string :heading_bg_image
      t.references :page_heading, foreign_key: true

      t.timestamps
    end
  end
end
