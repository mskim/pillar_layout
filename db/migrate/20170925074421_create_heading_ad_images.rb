class CreateHeadingAdImages < ActiveRecord::Migration[5.1]
  def change
    create_table :heading_ad_images do |t|
      t.string :heading_ad_image
      t.float :x
      t.float :y
      t.float :width
      t.float :height
      t.float :x_in_unit
      t.float :y_in_unit
      t.float :width_in_unit
      t.float :height_in_unit
      t.references :page_heading, foreign_key: true
      t.string :advertiser

      t.timestamps
    end
  end
end
