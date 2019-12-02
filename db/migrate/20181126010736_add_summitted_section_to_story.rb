class AddSummittedSectionToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :summitted_section, :string
  end
end
