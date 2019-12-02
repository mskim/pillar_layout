class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.integer :page_number
      t.string :section_name
      t.integer :column
      t.integer :row
      t.string :ad_type
      t.integer :story_count
      t.boolean :color_page
      t.string :profile
      t.references :issue
      t.references :page_plan
      # t.references :issue, foreign_key: true
      # t.references :page_plan, foreign_key: true
      t.integer :template_id

      t.timestamps
    end
  end
end
