class CreateAnnotationUnderlines < ActiveRecord::Migration[6.0]
  def change
    create_table :annotation_underlines do |t|
      t.decimal :x
      t.decimal :y
      t.decimal :width
      t.decimal :height
      t.string :color
      t.references :annotation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
