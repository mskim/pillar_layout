class AddWirePicturesToReporterImage < ActiveRecord::Migration[5.2]
  def change
    add_column :reporter_images, :wire_pictures, :string
  end
end
