class CreateGroupImages < ActiveRecord::Migration[6.0]
  def change
    create_table :group_images do |t|
      t.string :title
      t.string :caption
      t.string :source
      t.string :direction
      t.integer :position
      t.references :working_article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
