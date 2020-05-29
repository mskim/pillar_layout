class AddDropFloorToWorkingArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :working_articles, :drop_floor, :integer,default: 0
  end
end
