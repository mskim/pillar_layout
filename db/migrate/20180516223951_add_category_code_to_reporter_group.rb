class AddCategoryCodeToReporterGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :reporter_groups, :category_code, :integer
  end
end
