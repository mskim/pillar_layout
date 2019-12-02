class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :text
      t.string :image
      t.float :x_value
      t.float :y_value
      t.float :width
      t.float :height
      t.references :proof, foreign_key: true

      t.timestamps
    end
  end
end
