class AddProfileImagePositionToWorkingArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :profile_image_position, :string
  end
end
