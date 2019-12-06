# == Schema Information
#
# Table name: reporter_graphics
#
#  id             :bigint           not null, primary key
#  caption        :string
#  column         :integer
#  data           :text
#  designer       :string
#  extra_height   :integer
#  request        :text
#  row            :integer
#  section_name   :string
#  source         :string
#  status         :string
#  title          :string
#  used_in_layout :boolean
#  wire_pictures  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
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
