class AddBackupToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :backup, :text
  end
end
