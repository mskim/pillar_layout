class AddCategoryCodeToWorkingArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :working_articles, :category_code, :integer
  end
end
