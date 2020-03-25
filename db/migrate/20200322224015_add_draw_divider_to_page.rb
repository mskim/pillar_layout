class AddDrawDividerToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :draw_divider, :boolean
  end
end
