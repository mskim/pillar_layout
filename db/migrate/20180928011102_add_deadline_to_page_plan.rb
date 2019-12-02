class AddDeadlineToPagePlan < ActiveRecord::Migration[5.2]
  def change
    add_column :page_plans, :deadline, :string
  end
end
