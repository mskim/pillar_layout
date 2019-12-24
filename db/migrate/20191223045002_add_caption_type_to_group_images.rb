class AddCaptionTypeToGroupImages < ActiveRecord::Migration[6.0]
  def change
    add_column :group_images, :caption_type, :string
  end
end
