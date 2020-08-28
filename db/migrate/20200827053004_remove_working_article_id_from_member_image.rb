class RemoveWorkingArticleIdFromMemberImage < ActiveRecord::Migration[6.0]
  def change
    remove_column :member_images, :working_article_id, :string
  end
end
