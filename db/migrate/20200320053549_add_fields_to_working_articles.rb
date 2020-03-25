class AddFieldsToWorkingArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :frame_sides, :string
    add_column :working_articles, :frame_color, :string
    add_column :working_articles, :frame_thickness, :float
  end
end
