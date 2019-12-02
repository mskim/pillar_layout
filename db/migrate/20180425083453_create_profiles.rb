class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :profile_image
      t.string :work
      t.string :position
      t.string :email
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
