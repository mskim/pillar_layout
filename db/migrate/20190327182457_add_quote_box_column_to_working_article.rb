class AddQuoteBoxColumnToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :quote_box_column, :integer
    add_column :working_articles, :quote_box_type, :integer
    add_column :working_articles, :quote_box_show, :boolean
  end
end
