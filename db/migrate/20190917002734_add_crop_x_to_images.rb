class AddCropXToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :crop_x, :integer
    add_column :images, :crop_y, :integer
    add_column :images, :crop_w, :integer
    add_column :images, :crop_h, :integer
  end
end
