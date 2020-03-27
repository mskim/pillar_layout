# frozen_string_literal: true

class CreateMemberImages < ActiveRecord::Migration[6.0]
  def change
    create_table :member_images do |t|
      t.string :title
      t.string :caption
      t.string :source
      t.integer :order

      t.timestamps
    end
  end
end
