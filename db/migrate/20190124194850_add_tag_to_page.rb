class AddTagToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :tag, :string
  end
end
