class CreateProofs < ActiveRecord::Migration[5.2]
  def change
    create_table :proofs do |t|
      t.references :working_article, foreign_key: true
      t.string :image_url
      t.timestamps
    end
  end
end
