class AddEmbbeddedToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :embedded, :boolean
  end
end
