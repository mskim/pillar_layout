class AddQuotePositionToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :quote_position, :integer
    add_column :working_articles, :quote_x_grid, :integer
    add_column :working_articles, :quote_v_extra_space, :integer
    add_column :working_articles, :quote_alignment, :string
    add_column :working_articles, :quote_line_type, :string
  end
end
