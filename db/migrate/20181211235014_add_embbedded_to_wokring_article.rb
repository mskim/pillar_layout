class AddEmbbeddedToWokringArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :embedded, :boolean
  end
end
