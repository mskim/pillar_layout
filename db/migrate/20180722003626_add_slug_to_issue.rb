class AddSlugToIssue < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :slug, :string
    add_index :issues, :slug, unique: true

  end
end
