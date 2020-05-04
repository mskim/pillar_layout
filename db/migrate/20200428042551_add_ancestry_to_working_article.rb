class AddAncestryToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :ancestry, :string
  end
end
