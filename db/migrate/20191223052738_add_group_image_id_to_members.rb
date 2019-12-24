class AddGroupImageIdToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :group_image_id, :integer
  end
end
