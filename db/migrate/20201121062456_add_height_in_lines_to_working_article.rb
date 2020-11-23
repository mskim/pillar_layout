class AddHeightInLinesToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :base_height_in_lines, :integer
  end
end
