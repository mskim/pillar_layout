class AddOrderToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :order, :integer
    add_column :graphics, :order, :integer
  end
end
