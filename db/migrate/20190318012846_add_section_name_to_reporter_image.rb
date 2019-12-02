class AddSectionNameToReporterImage < ActiveRecord::Migration[5.2]
  def change
    add_column :reporter_images, :section_name, :string
    add_column :reporter_images, :used_in_layout, :boolean
  end
end
