class AddAnnouncementTextToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :announcement_text, :string
    add_column :working_articles, :announcement_column, :integer
    add_column :working_articles, :announcement_color, :string
  end
end
