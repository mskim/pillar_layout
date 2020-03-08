class CreateSpreadAdBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :spread_ad_boxes do |t|
      t.string :ad_type
      t.string :advertiser
      t.integer :row
      t.float :width
      t.float :height
      t.references :spread, null: false, foreign_key: true

      t.timestamps
    end
  end
end
