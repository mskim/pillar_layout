class AddMemberImgToMemberImages < ActiveRecord::Migration[6.0]
  def change
    add_column :member_images, :member_img, :string
  end
end
