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

class ArticlePlan < ApplicationRecord
  belongs_to :page_plan

  def reporters_of_group
    page_plan.reporters_of_group.map{|r| r.name}
  end
end
