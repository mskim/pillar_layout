class AddSlugToWorkingArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :working_articles, :slug, :string
    add_index :working_articles, :slug, unique: true
  end
end
