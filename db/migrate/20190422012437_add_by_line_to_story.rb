class AddByLineToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :by_line, :string
  end
end
