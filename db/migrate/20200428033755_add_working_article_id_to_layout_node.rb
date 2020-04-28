class AddWorkingArticleIdToLayoutNode < ActiveRecord::Migration[6.0]
  def change
    add_column :layout_nodes, :working_article_id, :integer
  end
end
