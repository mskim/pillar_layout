# == Schema Information
#
# Table name: text_styles
#
#  id                    :integer          not null, primary key
#  alignment             :string
#  box_attributes        :text
#  category              :string
#  english               :string
#  first_line_indent     :float
#  font                  :string
#  font_family           :string
#  font_size             :float
#  graphic_attributes    :text
#  italic                :float
#  korean_name           :string
#  markup                :string
#  scale                 :float
#  space_after_in_lines  :integer
#  space_before_in_lines :integer
#  space_width           :float
#  text_color            :string
#  text_height_in_lines  :integer
#  text_line_spacing     :float
#  tracking              :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  publication_id        :integer
#
# Indexes
#
#  index_text_styles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'test_helper'

class TextStyleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
