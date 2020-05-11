class AddAttachedTypeToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :attached_type, :string
  end
end
