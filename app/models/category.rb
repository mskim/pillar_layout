# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
   has_ancestry


  def self.parse
    category_path = "#{Rails.root}/public/1/category/category.yml"
    source = YAML::load_file(category_path)
    source.each do |category, sub|
        c = Category.create(name: category)
        sub.each do |chidren|
            Category.create(name: category, parent: c)
        end
    end

  end
end
