class CreateReporterImages < ActiveRecord::Migration[5.2]
  def change
    create_table :reporter_images do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :caption
      t.string :source
      t.string :reporter_image

      t.timestamps
    end
  end
end
