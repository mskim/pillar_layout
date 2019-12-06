# == Schema Information
#
# Table name: article_plans
#
#  id           :bigint           not null, primary key
#  char_count   :string
#  order        :integer
#  reporter     :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  page_plan_id :bigint
#
# Indexes
#
#  index_article_plans_on_page_plan_id  (page_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_plan_id => page_plans.id)
#

require 'test_helper'

class ArticlePlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
