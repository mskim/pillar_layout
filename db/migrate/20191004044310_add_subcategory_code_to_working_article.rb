class AddSubcategoryCodeToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :subcategory_code, :string
  end
end
