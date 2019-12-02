# == Schema Information
#
# Table name: profiles
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  profile_image     :string
#  work              :string
#  position          :string
#  email             :string
#  publication_id    :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :string
#  category_code     :integer
#  profile_jpg_image :string
#
# Indexes
#
#  index_profiles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
