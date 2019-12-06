# == Schema Information
#
# Table name: story_categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe StoryCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
