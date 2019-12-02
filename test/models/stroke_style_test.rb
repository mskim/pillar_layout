# == Schema Information
#
# Table name: stroke_styles
#
#  id             :bigint(8)        not null, primary key
#  klass          :string
#  name           :string
#  stroke         :text
#  publication_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_stroke_styles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'test_helper'

class StrokeStyleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
