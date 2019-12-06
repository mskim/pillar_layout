# == Schema Information
#
# Table name: opinion_writers
#
#  id                :bigint           not null, primary key
#  category_code     :integer
#  cell              :string
#  email             :string
#  name              :string
#  opinion_image     :string
#  opinion_jpg_image :string
#  position          :string
#  title             :string
#  work              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  publication_id    :bigint
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
