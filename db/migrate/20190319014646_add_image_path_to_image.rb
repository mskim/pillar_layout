class AddImagePathToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :reporter_image_path, :string
  end
end
