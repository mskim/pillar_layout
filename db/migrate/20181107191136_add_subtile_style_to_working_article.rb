class AddSubtileStyleToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :boxed_subtitle_type, :integer
    add_column :working_articles, :boxed_subtitle_text, :string
  end
end
