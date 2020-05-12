class AddAttachedPositionToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :attached_position, :string
  end
end
