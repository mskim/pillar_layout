class AddPillarPathToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :working_articles, :pillar_order, :string
  end
end
