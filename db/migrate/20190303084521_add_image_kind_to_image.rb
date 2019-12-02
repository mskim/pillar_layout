class AddImageKindToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :image_kind, :string
  end
end
