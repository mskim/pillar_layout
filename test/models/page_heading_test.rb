# == Schema Information
#
# Table name: page_headings
#
#  id           :integer          not null, primary key
#  page_number  :integer
#  section_name :string
#  date         :string
#  layout       :text
#  page_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require_relative '../test_helper'

class PageHeadingTest < ActiveSupport::TestCase
  test "the truth" do
    con = RLayout::Container.new(width: 1031.81, height: 41.54771428571429, layout_direction: 'horinoztal', stroke_sizes: [0,0,0,1], stroke_width: 0.3) do
      text('2', font: 'YDVYGOStd14', font_size: 12, text_color: "CMYK=0,0,0,100", width: 50, height: 44)
      container(layout_expand: :width, layout_direction: 'horinoztal', layout_length: 20, layout_align: 'justified') do
        text('0000년 0월 0일 0요일', width: 200, font_size: 10, text_color: "CMYK=0,0,0,100", text_alignment: 'left')
        text('정치', font: 'YDVYMjOStd14', width: 200, font_size: 10, text_color: "CMYK=0,0,0,100")
        text('내일신문', width: 230, text_alignment: 'right', font_size: 16)
      end
      relayout!
    end

    assert_equal  Container, con.class
  end
end
