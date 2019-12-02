class AddPersonalImageInWorkingArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :has_profile_image, :boolean
  end
end
