class AddWorkingArticleReferenceToMemberImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :member_images, :working_article, null: false, foreign_key: true
  end
end
