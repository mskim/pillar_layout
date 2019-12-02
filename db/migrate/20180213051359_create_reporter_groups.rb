class CreateReporterGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :reporter_groups do |t|
      t.string :section
      t.string :page_range
      t.string :leader

      t.timestamps
    end
  end
end
