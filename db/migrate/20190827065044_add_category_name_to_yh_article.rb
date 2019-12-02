class AddCategoryNameToYhArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :yh_articles, :category_name, :string
    add_column :yh_articles, :category_code, :string
  end
end
