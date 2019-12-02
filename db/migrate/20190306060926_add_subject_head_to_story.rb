class AddSubjectHeadToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :subject_head, :string
    add_column :stories, :kind, :string
  end
end
