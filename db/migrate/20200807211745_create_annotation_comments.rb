class CreateAnnotationComments < ActiveRecord::Migration[6.0]
  def change
    create_table :annotation_comments do |t|
      t.references :annotation, null: false, foreign_key: true
      t.references :user
      t.text :comment
      t.string :shape
      t.string :color
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
