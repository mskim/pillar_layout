class AddGroupImageIdToMemberImages < ActiveRecord::Migration[6.0]
  def change
    add_column :member_images, :group_image_id, :integer
  end
end
