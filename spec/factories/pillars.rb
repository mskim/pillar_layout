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
#  profile                 :string
#  region_type             :string
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  region_id               :bigint
#
# Indexes
#
#  index_pillars_on_region_id  (region_id)
#

FactoryBot.define do
  factory :pillar do
    grid_x { 1 }
    grid_y { 1 }
    column { 1 }
    row { 1 }
    order { 1 }
    box_count { 1 }
    layout_with_pillar_path { "MyText" }
    layout { "MyText" }
    profile { "MyString" }
    finger_print { "MyString" }
    region { nil }
    region_type { "MyString" }
  end
end
