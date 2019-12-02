class AddYInLineToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :y_in_lines, :integer
    add_column :articles, :height_in_lines, :integer
  end
end
