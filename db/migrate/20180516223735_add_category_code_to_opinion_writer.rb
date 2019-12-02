class AddCategoryCodeToOpinionWriter < ActiveRecord::Migration[5.1]
  def change
    add_column :opinion_writers, :category_code, :integer
  end
end
