class AddSideLineToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :left_line, :integer, :default => 0
    add_column :working_articles, :top_line, :integer, :default => 0
    add_column :working_articles, :right_line, :integer, :default => 0
    add_column :working_articles, :bottom_line, :integer, :default => 0
  end
end
