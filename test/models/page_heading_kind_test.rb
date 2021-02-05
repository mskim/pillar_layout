# == Schema Information
#
# Table name: page_heading_kinds
#
#  id              :bigint           not null, primary key
#  bg_image        :string
#  height_in_lines :integer
#  layout_erb      :text
#  page_type       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  publication_id  :bigint
#
# Indexes
#
#  index_page_heading_kinds_on_publication_id  (publication_id)
#
require "test_helper"

class PageHeadingKindTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
