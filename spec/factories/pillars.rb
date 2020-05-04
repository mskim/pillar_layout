# == Schema Information
#
# Table name: pillars
#
#  id               :bigint           not null, primary key
#  box_count        :integer
#  column           :integer
#  direction        :string
#  grid_x           :integer
#  grid_y           :integer
#  has_drop_article :boolean
#  order            :integer
#  page_ref_type    :string
#  profile          :string
#  row              :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  page_ref_id      :bigint
#
# Indexes
#
#  index_pillars_on_page_ref_id  (page_ref_id)
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
    page_ref { nil }
    page_ref_type { "MyString" }
  end
end
