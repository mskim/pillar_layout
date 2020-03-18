class AddVariablePageCountToPublication < ActiveRecord::Migration[6.0]
  def change
    add_column :publications, :variable_page_count, :boolean
  end
end
