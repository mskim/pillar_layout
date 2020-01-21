class AddSelectedForWebToStories < ActiveRecord::Migration[6.0]
  def change
    add_column :stories, :selected_for_web, :boolean
  end
end
