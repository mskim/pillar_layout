# == Schema Information
#
# Table name: profiles
#
#  id                :bigint           not null, primary key
#  category_code     :integer
#  email             :string
#  name              :string
#  position          :string
#  profile_image     :string
#  profile_jpg_image :string
#  title             :string
#  work              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  publication_id    :bigint
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
