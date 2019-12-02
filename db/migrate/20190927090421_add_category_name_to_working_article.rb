class AddCategoryNameToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :category_name, :string
  end
end
