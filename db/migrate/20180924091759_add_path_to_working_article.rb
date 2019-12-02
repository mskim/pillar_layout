class AddPathToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :publication_name, :string
    add_column :working_articles, :path, :string
    add_column :working_articles, :date, :date
    add_column :working_articles, :page_number, :integer
    add_column :working_articles, :page_heading_margin_in_lines, :integer
    add_column :working_articles, :grid_width, :float
    add_column :working_articles, :grid_height, :float
    add_column :working_articles, :gutter, :float
    
  end
end
