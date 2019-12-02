class AddByLineToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :by_line, :string
    add_column :working_articles, :price, :float
  end
end
