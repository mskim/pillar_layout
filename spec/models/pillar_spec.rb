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
#  page_ref_type           :string
#  profile                 :string
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  page_ref_id             :bigint
#
# Indexes
#
#  index_pillars_on_page_ref_id  (page_ref_id)
#

require 'rails_helper'

RSpec.describe Pillar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
