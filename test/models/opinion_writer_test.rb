# == Schema Information
#
# Table name: opinion_writers
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  title             :string
#  work              :string
#  position          :string
#  email             :string
#  cell              :string
#  opinion_image     :string
#  publication_id    :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_code     :integer
#  opinion_jpg_image :string
#
# Indexes
#
#  index_opinion_writers_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'test_helper'

class OpinionWriterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
