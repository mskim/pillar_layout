
# Migration for chnaging default

class ChangeDefaultvalueForHideSeasonSelector < ActiveRecord::Migration 
  def change 
    change_column_default :plussites, :hide_season_selector, from: false, to: true 
  end
end

class ChangeDefaultvalueForImage < ActiveRecord::Migration 
  def change 
    change_column_default :images, :column, from: nil, to: 1 
    change_column_default :images, :row, from: nil, to: 1 
  end
end

class ChangeDefaultvalueForGraphic < ActiveRecord::Migration 
  def change 
    change_column_default :graphics, :column, from: nil, to: 1 
    change_column_default :graphics, :row, from: nil, to: 1 
  end
end