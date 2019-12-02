class AddQuoteBoxSizeToWorkingArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :working_articles, :quote_box_size, :integer
  end
end
