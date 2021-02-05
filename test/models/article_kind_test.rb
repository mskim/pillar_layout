# == Schema Information
#
# Table name: article_kinds
#
#  id                     :bigint           not null, primary key
#  bottoms_space_in_lines :integer
#  input_fields           :text
#  layout_erb             :text
#  line_draw_sides        :text
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  publication_id         :bigint           not null
#
# Indexes
#
#  index_article_kinds_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#
require "test_helper"

class ArticleKindTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
