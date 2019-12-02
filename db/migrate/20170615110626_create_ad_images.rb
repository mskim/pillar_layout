class CreateAdImages < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_images do |t|
      t.string :ad_type
      t.integer :column
      t.integer :row
      t.string :ad_image    #carrierwave uploader
      t.string :advertiser
      t.integer :page_number
      t.integer :article_number
      t.integer :ad_box_id
      t.integer :issue_id
      t.boolean :used_in_layout

      t.timestamps
    end
  end
end
