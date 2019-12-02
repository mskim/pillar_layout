class AddLayoutToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :layout, :text
  end
end
