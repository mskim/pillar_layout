class CreateReporterGraphics < ActiveRecord::Migration[5.2]
  def change
    create_table :reporter_graphics do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :caption
      t.string :source
      t.string :wire_pictures
      t.string :section_name
      t.boolean :used_in_layout

      t.timestamps
    end
  end
end
