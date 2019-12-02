class AddDisplayNameToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :display_name, :string
  end
end
