class AddCategoryNameToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :category_name, :string
  end
end
