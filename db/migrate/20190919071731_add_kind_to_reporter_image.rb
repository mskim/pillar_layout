class AddKindToReporterImage < ActiveRecord::Migration[5.2]
  def change
    add_column :reporter_images, :kind, :string
  end
end
