class CreateAdPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_plans do |t|
      t.date :date
      t.integer :page_number
      t.string :ad_type
      t.string :advertiser
      t.boolean :color_page
      t.string :comment

      t.timestamps
    end
  end
end
