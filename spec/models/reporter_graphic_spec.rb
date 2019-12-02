# == Schema Information
#
# Table name: reporter_graphics
#
#  id             :bigint(8)        not null, primary key
#  user_id        :bigint(8)
#  title          :string
#  caption        :string
#  source         :string
#  wire_pictures  :string
#  section_name   :string
#  used_in_layout :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  column         :integer
#  row            :integer
#  extra_height   :integer
#  status         :string
#  designer       :string
#  request        :text
#  data           :text
#
# Indexes
#
#  index_reporter_graphics_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe ReporterGraphic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
