class RemoveHeightInLinesFromWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    remove_column :working_articles, :height_in_lines, :integer
    remove_column :working_articles, :pushed_line_count, :integer
  end
end
