class AddDrawDividerToSection < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :draw_divider, :boolean
  end
end
