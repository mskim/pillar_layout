class AddFrameBgColorToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :frame_bg_color, :string
    add_column :working_articles, :locked, :boolean
    
  end
end
