class CreateOpinionWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :opinion_writers do |t|
      t.string :name
      t.string :title
      t.string :work
      t.string :position
      t.string :email
      t.string :cell
      t.string :opinion_image
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
