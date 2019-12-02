# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
