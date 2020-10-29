# == Schema Information
#
# Table name: pages
#
#  id                           :integer          not null, primary key
#  ad_type                      :string
#  article_line_thickness       :float
#  bottom_margin                :float
#  clone_name                   :string
#  color_page                   :boolean
#  column                       :integer
#  date                         :date
#  display_name                 :string
#  draw_divider                 :boolean
#  edition                      :string           default("A")
#  grid_height                  :float
#  grid_width                   :float
#  gutter                       :float
#  height                       :float
#  layout                       :text
#  left_margin                  :float
#  lines_per_grid               :float
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  path                         :string
#  profile                      :string
#  right_margin                 :float
#  row                          :integer
#  section_name                 :string
#  slug                         :string
#  story_count                  :integer
#  tag                          :string
#  top_margin                   :float
#  width                        :float
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  issue_id                     :integer
#  page_plan_id                 :integer
#  publication_id               :integer
#  template_id                  :integer
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
