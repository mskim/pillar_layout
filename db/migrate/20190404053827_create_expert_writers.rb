class CreateExpertWriters < ActiveRecord::Migration[5.2]
  def change
    create_table :expert_writers do |t|
      t.string :name
      t.string :work
      t.string :position
      t.string :email
      t.string :category_code
      t.string :expert_image
      t.string :expert_jpg_image

      t.timestamps
    end
  end
end
