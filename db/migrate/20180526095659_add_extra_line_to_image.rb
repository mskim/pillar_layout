class AddExtraLineToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :extra_line, :integer
  end
end
