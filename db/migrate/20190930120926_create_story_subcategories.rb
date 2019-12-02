class CreateStorySubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :story_subcategories do |t|
      t.string :name
      t.string :code
      t.references :story_category, foreign_key: true
      t.timestamps
    end
  end
end
