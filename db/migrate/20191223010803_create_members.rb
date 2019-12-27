class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :caption_title
      t.text :caption_description
      t.string :source
      t.integer :order

      t.timestamps
    end
  end
end
