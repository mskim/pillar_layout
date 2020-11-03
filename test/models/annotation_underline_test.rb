# == Schema Information
#
# Table name: annotation_underlines
#
#  id            :bigint           not null, primary key
#  color         :string
#  height        :decimal(, )
#  width         :decimal(, )
#  x             :decimal(, )
#  y             :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  annotation_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_annotation_underlines_on_annotation_id  (annotation_id)
#  index_annotation_underlines_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class AnnotationUnderlineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
