class CreateArticleKinds < ActiveRecord::Migration[6.1]
  def change
    create_table :article_kinds do |t|
      t.references :publication, null: false, foreign_key: true
      t.string :name
      t.text :line_draw_sides
      t.text :input_fields
      t.integer :bottoms_space_in_lines
      t.text :layout_erb

      t.timestamps
    end
  end
end
