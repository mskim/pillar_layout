class AddSideLineToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :left_line, :integer, :default => 0
    add_column :images, :top_line, :integer, :default => 0
    add_column :images, :right_line, :integer, :default => 0
    add_column :images, :bottom_line, :integer, :default => 0
  end
end
