class AddColumnToReporterGraphic < ActiveRecord::Migration[5.2]
  def change
    add_column :reporter_graphics, :column, :integer
    add_column :reporter_graphics, :row, :integer
    add_column :reporter_graphics, :extra_height, :integer
    add_column :reporter_graphics, :status, :string
    add_column :reporter_graphics, :designer, :string
    add_column :reporter_graphics, :request, :text
    add_column :reporter_graphics, :data, :text
  end
end
