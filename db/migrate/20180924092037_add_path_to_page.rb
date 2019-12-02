class AddPathToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :publication_id, :integer
    add_column :pages, :path, :string
    add_column :pages, :date, :date
    add_column :pages, :grid_width, :float
    add_column :pages, :grid_height, :float
    add_column :pages, :lines_per_grid, :float
    add_column :pages, :width, :float
    add_column :pages, :height, :float
    add_column :pages, :left_margin, :float
    add_column :pages, :top_margin, :float
    add_column :pages, :right_margin, :float
    add_column :pages, :bottom_margin, :float
    add_column :pages, :gutter, :float
    add_column :pages, :article_line_thickness, :float
  end
end
