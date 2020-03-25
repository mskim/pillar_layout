class AddExcelFileToIssues < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :excel_file, :string
  end
end
