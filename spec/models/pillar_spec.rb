# == Schema Information
#
# Table name: pillars
#
#  id                      :bigint           not null, primary key
#  box_count               :integer
#  column                  :integer
#  direction               :string
#  finger_print            :string
#  grid_x                  :integer
#  grid_y                  :integer
#  layout                  :text
#  layout_with_pillar_path :text
#  order                   :integer
#  region_type           :string
#  profile                 :string
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  region_id             :bigint
#
# Indexes
#
#  index_pillars_on_region_id  (region_id)
#

require 'rails_helper'

RSpec.describe Pillar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
