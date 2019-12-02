class AddCategoryToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :category_code, :string
    add_column :stories, :price, :float
  end
end
