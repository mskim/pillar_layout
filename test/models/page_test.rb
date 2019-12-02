# == Schema Information
#
# Table name: pages
#
#  id                           :integer          not null, primary key
#  page_number                  :integer
#  section_name                 :string
#  column                       :integer
#  row                          :integer
#  ad_type                      :string
#  story_count                  :integer
#  color_page                   :boolean
#  profile                      :string
#  issue_id                     :integer
#  page_plan_id                 :integer
#  template_id                  :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  clone_name                   :string
#  slug                         :string
#  layout                       :text
#  publication_id               :integer
#  path                         :string
#  date                         :date
#  grid_width                   :float
#  grid_height                  :float
#  lines_per_grid               :float
#  width                        :float
#  height                       :float
#  left_margin                  :float
#  top_margin                   :float
#  right_margin                 :float
#  bottom_margin                :float
#  gutter                       :float
#  article_line_thickness       :float
#  page_heading_margin_in_lines :integer
#  tag                          :string
#  display_name                 :string
#
# Indexes
#
#  index_pages_on_issue_id      (issue_id)
#  index_pages_on_page_plan_id  (page_plan_id)
#  index_pages_on_slug          (slug) UNIQUE
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "create class" do
    assert true
  end

  test "change_template" do

    
  end
end
