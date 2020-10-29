class CreateAnnotations < ActiveRecord::Migration[6.0]
  def change
    create_table :annotations do |t|
      t.references :working_article, null: false, foreign_key: true
      t.integer :version

      t.timestamps
    end
  end
end
