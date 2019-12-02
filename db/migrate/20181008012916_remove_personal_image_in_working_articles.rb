class RemovePersonalImageInWorkingArticles < ActiveRecord::Migration[5.2]
  def change
   remove_column :working_articles, :personal_image, :string
  end
end
