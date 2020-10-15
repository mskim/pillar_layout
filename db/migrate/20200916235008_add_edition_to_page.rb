class AddEditionToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :edition, :string, default:'A'
  end
end
