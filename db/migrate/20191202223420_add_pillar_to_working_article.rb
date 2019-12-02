class AddPillarToWorkingArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :working_articles, :pillar, foreign_key: true
  end
end
