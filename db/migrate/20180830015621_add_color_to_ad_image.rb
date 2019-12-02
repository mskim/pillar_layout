class AddColorToAdImage < ActiveRecord::Migration[5.1]
  def change
    add_column :ad_images, :color, :boolean
    remove_column :ad_images, :page_number, :integer
    remove_column :ad_images, :article_number, :integer
  end
end
