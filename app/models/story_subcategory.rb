# == Schema Information
#
# Table name: story_subcategories
#
#  id                :bigint           not null, primary key
#  code              :string
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  story_category_id :bigint
#
# Indexes
#
#  index_story_subcategories_on_story_category_id  (story_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (story_category_id => story_categories.id)
#

class StorySubcategory < ApplicationRecord
  # belongs_to :story
  # belongs_to :working_article
  belongs_to :story_category
  # has_many :working_article
  validates :name, :code, presence:true
  validates_uniqueness_of  :name, :code
end
