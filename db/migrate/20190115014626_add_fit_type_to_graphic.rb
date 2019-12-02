class AddFitTypeToGraphic < ActiveRecord::Migration[5.2]
  def change
    add_column :graphics, :fit_type, :string
  end
end
