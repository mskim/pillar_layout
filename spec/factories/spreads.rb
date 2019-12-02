# == Schema Information
#
# Table name: spreads
#
#  id            :bigint(8)        not null, primary key
#  issue_id      :bigint(8)
#  left_page_id  :integer
#  right_page_id :integer
#  ad_box_id     :integer
#  color_page    :boolean
#  width         :float
#  height        :float
#  left_margin   :float
#  top_margin    :float
#  right_margin  :float
#  bottom_margin :float
#  page_gutter   :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_spreads_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

FactoryBot.define do
  factory :spread do
    issue { nil }
    left_page_id { 1 }
    right_page_id { 1 }
    ad_box_id { 1 }
    color_page { false }
    width { 1.5 }
    height { 1.5 }
    left_margin { 1.5 }
    top_margin { 1.5 }
    right_margin { 1.5 }
    bottom_margin { 1.5 }
    page_gutter { 1.5 }
  end
end
