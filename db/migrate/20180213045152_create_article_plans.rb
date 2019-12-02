class CreateArticlePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :article_plans do |t|
      t.references :page_plan, foreign_key: true
      t.string :reporter
      t.integer :order
      t.string :title
      t.string :char_count

      t.timestamps
    end
  end
end
