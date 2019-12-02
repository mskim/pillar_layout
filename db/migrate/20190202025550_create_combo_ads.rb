class CreateComboAds < ActiveRecord::Migration[5.2]
  def change
    create_table :combo_ads do |t|
      t.string :base_ad
      t.integer :column
      t.integer :row
      t.text :layout
      t.string :profile

      t.timestamps
    end
  end
end
