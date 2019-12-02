class AddExtendedLineCountToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :extended_line_count, :integer
    add_column :articles, :pushed_line_count, :integer
  end
end
