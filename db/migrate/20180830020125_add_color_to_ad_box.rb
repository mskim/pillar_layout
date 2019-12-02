class AddColorToAdBox < ActiveRecord::Migration[5.1]
  def change
    add_column :ad_boxes, :color, :boolean
  end
end
