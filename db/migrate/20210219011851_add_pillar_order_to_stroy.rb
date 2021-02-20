class AddPillarOrderToStroy < ActiveRecord::Migration[6.1]
  def change
    add_column :stories, :page_number, :integer
    add_column :stories, :pillar_order, :string
    add_column :stories, :image_info, :text
    add_column :stories, :graphic_info, :text
  end
end
