class AddPathToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :publication_name, :string
    add_column :articles, :path, :string
    add_column :articles, :page_heading_margin_in_lines, :integer
    add_column :articles, :grid_width, :float
    add_column :articles, :grid_height, :float
    add_column :articles, :gutter, :float
  end
end
