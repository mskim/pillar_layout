# == Schema Information
#
# Table name: story_subcategories
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  code              :string
#  story_category_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_story_subcategories_on_story_category_id  (story_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (story_category_id => story_categories.id)
#

require 'rails_helper'

RSpec.describe StorySubcategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
