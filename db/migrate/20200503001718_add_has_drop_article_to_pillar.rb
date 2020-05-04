class AddHasDropArticleToPillar < ActiveRecord::Migration[6.0]
  def change
    add_column :pillars, :has_drop_article, :boolean
  end
end
