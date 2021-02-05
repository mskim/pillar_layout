class CreatePageHeadingKinds < ActiveRecord::Migration[6.1]
  def change
    create_table :page_heading_kinds do |t|
      t.references :publication
      t.string :page_type
      t.text :layout_erb
      t.integer :height_in_lines
      t.string :bg_image

      t.timestamps
    end
  end
end
