# == Schema Information
#
# Table name: reporter_images
#
#  id             :bigint           not null, primary key
#  caption        :string
#  kind           :string
#  reporter_image :string
#  section_name   :string
#  source         :string
#  title          :string
#  used_in_layout :boolean
#  wire_pictures  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_reporter_images_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe ReporterImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
