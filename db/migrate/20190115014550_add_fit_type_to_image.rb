class AddFitTypeToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :fit_type, :string
  end
end
