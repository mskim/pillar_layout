class AddColumnToGroupImage < ActiveRecord::Migration[6.0]
  def change
    add_column :group_images, :column, :integer
    add_column :group_images, :row, :integer
    add_column :group_images, :extended_line_count, :integer
  end
end
