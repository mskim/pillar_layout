class AddSelectedToAnnotationComments < ActiveRecord::Migration[6.0]
  def change
    add_column :annotation_comments, :selected, :boolean
  end
end
