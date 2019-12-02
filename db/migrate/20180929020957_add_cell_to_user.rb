class AddCellToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cell, :string
    add_column :users, :title, :string
    add_column :users, :group, :string
  end
end
