class CreatePagePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :page_plans do |t|
      t.integer :page_number
      t.string :section_name
      t.integer :selected_template_id
      t.integer :column
      t.integer :row
      t.integer :story_count
      t.string :profile
      t.string :ad_type
      t.string :advertiser
      t.boolean :color_page
      t.boolean :dirty
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end
