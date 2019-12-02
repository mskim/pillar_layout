class AddOverlapToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :overlap, :text
  end
end
