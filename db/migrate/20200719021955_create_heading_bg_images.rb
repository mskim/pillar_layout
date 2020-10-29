class CreateHeadingBgImages < ActiveRecord::Migration[5.1]
  def change
    create_table :heading_bg_images do |t|
      t.string :name
      t.string :paper_size #대판, 버르리너, 타블로이드
      t.string :heading_bg_image

      t.timestamps
    end
  end
end
