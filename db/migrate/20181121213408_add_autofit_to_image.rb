class AddAutofitToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :auto_size, :integer
  end
end
