# frozen_string_literal: true

class CreateGroupImages < ActiveRecord::Migration[6.0]
  def change
    create_table :group_images do |t|
      t.string :caption_title
      t.text :caption_description
      t.string :source
      t.integer :position
      t.string :direction

      t.timestamps
    end
  end
end
