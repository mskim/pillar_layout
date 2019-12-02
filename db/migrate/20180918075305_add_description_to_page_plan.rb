class AddDescriptionToPagePlan < ActiveRecord::Migration[5.2]
  def change
    add_column :page_plans, :description, :text
  end
end
