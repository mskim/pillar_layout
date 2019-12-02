class RemoveDetailModeFromImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :detail_mode, :boolean
  end
end
