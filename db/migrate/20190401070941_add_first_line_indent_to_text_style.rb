class AddFirstLineIndentToTextStyle < ActiveRecord::Migration[5.2]
  def change
    add_column :text_styles, :first_line_indent, :float
  end
end
