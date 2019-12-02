class CreateReporters < ActiveRecord::Migration[5.1]
  def change
    create_table :reporters do |t|
      t.string :name
      t.string :email
      t.string :title
      t.string :cell
      t.references :reporter_group
      # t.references :reporter_group, foreign_key: true

      t.timestamps
    end
  end
end
