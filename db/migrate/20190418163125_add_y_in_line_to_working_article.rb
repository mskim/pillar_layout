class AddYInLineToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :y_in_lines, :integer
    add_column :working_articles, :height_in_lines, :integer
  end
end
