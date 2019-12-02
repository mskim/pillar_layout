# frozen_string_literal: true

class AddStoryTypeToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :story_type, :string, default: '0'
  end
end
