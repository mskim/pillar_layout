class AddOverlapToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :overlap, :text
  end
end
