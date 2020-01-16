class AddPageCountToIssue < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :page_count, :integer
  end
end
