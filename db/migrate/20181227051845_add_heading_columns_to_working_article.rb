class AddHeadingColumnsToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :heading_columns, :integer
  end
end
