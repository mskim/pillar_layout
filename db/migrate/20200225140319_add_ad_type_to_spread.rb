class AddAdTypeToSpread < ActiveRecord::Migration[6.0]
  def change
    add_column :spreads, :ad_type, :string
  end
end
