class AddNotRelatedToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :not_related, :boolean
  end
end
