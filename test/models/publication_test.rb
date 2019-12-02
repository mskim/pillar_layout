# == Schema Information
#
# Table name: publications
#
#  id                             :integer          not null, primary key
#  name                           :string
#  unit                           :string
#  paper_size                     :string
#  width_in_unit                  :float
#  height_in_unit                 :float
#  left_margin_in_unit            :float
#  top_margin_in_unit             :float
#  right_margin_in_unit           :float
#  bottom_margin_in_unit          :float
#  gutter_in_unit                 :float
#  width                          :float
#  height                         :float
#  left_margin                    :float
#  top_margin                     :float
#  right_margin                   :float
#  bottom_margin                  :float
#  gutter                         :float
#  lines_per_grid                 :integer
#  page_count                     :integer
#  section_names                  :text
#  page_columns                   :text
#  row                            :integer
#  front_page_heading_height      :integer
#  inner_page_heading_height      :integer
#  article_bottom_spaces_in_lines :integer
#  article_line_draw_sides        :text
#  article_line_thickness         :float
#  draw_divider                   :boolean
#  cms_server_url                 :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require_relative '../test_helper'

class PublicationTest < ActiveSupport::TestCase

  test "should create Publication" do
    section_names = [
      '1면',
      '정치',
      '정치',
      '정치',
      '자치행정',
      '자치행정',
      '전면광고',
      '국제통일',
      '전면광고',
      '금융',
      '전면광고',
      '금융',
      '금융',
      '산업',
      '산업',
      '산업',
      '산업',
      '정책',
      '정책',
      '기획',
      '기획',
      '오피니언',
      '오피니언',
      '전면광고'
    ]
    h = {}
    h[:name]                            = '내일신문'
    h[:paper_size]                      = '신문대판'
    h[:unit]                            = 'mm'
    h[:width_in_unit]                   = 393  # 1114.02 pt
    h[:height_in_unit]                  = 545  # 1544.88 pt
    h[:left_margin_in_unit]             = 15   # 42.52
    h[:top_margin_in_unit]              = 15   # 42.52
    h[:right_margin_in_unit]            = 15   # 42.52
    h[:bottom_margin_in_unit]           = 15   # 42.52
    h[:gutter_in_unit]                  = 4.5  # 12.75
    h[:lines_per_grid]                  = 7
    h[:page_count]                      = 24
    h[:section_names]                   = section_names
    h[:page_columns]                    = [6,7]
    h[:front_page_heading_height]       = 8
    h[:inner_page_heading_height]       = 3
    h[:article_bottom_spaces_in_lines]  = 2
    h[:article_line_draw_sides]         = [0,0,0,1]
    h[:article_line_thickness]          = 0.3

    p = Publication.where(h).first_or_create
    assert p.save
    assert_equal 1114.02, p.width.round(2)
    assert_equal 393, p.width_in_unit
    assert_equal 1544.88, p.height.round(2)
    assert_equal 545, p.height_in_unit.round(2)
    assert_equal 147.00, p.grid_width(7).round(2)
    assert_equal 97.32, p.grid_height.round(2)
    assert_equal 13.9, p.body_line_height.round(2)
    assert_equal 4.9, p.body_line_height_in_mm
    assert_equal 8, p.front_page_heading_height
    assert_equal 3, p.inner_page_heading_height

    # assert_equal (p.left_margin), p.x_of_grid_frame(7, [0,0,7,5])
    # assert_equal (p.top_margin), p.x_of_grid_frame(7, [0,0,7,5])
    # assert_equal (p.width - p.left_margin - p.right_margin), p.width_of_grid_frame(7, [0,0,7,5])
    # assert_equal (p.width - p.left_margin - p.right_margin)*2/7, p.width_of_grid_frame(7, [0,0,2,5])
    # assert_equal (p.width - p.left_margin - p.right_margin)*3/7, p.width_of_grid_frame(7, [0,0,3,5])
    # assert_equal (p.height - p.top_margin - p.bottom_margin), p.height_of_grid_frame(7, [0,0,7,15])
  end
  #
  # test "should create Publication" do
  #
  #   p = Publication.new(name: '내일신문', paper_size: 'custom', width: 1116.85,  height: 1539.21, left_margin: 42.52, top_margin: 42.52, right_margin: 42.52, bottom_margin: 42.52, lines_per_grid: 7, divider: 20, gutter: 10, page_count:24)
  #
  #   # some_undefined_variable is not defined elsewhere in the test case
  #   assert_raises(NameError) do
  #     some_undefined_variable
  #   end
  # end
  # test "the truth" do
  #   assert true
  # end
end
