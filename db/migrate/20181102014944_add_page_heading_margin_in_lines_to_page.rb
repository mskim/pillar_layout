class AddPageHeadingMarginInLinesToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :page_heading_margin_in_lines, :integer
  end
end
