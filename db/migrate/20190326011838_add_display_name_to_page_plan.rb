class AddDisplayNameToPagePlan < ActiveRecord::Migration[5.2]
  def change
    add_column :page_plans, :display_name, :string
  end
end
