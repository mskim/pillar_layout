class AddDateToHeadingAdImage < ActiveRecord::Migration[5.2]
  def change
    add_column :heading_ad_images, :date, :date
  end
end
