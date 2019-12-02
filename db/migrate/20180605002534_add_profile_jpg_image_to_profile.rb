class AddProfileJpgImageToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :profile_jpg_image, :string
  end
end
