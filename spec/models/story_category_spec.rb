# == Schema Information
#
# Table name: story_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe StoryCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
