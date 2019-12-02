class AddCategoryCodeToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :title, :string
    add_column :profiles, :category_code, :integer
  end
end
