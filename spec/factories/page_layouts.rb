# == Schema Information
#
# Table name: page_layouts
#
#  id                      :bigint           not null, primary key
#  ad_type                 :string
#  column                  :integer
#  doc_height              :float
#  doc_width               :float
#  grid_height             :float
#  grid_width              :float
#  gutter                  :float
#  layout                  :text
#  layout_with_pillar_path :text
#  like                    :integer
#  margin                  :float
#  page_type               :string
#  pillar_count            :integer
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryBot.define do
  factory :page_layout do
    doc_width { 1.5 }
    doc_height { 1.5 }
    ad_type { "MyString" }
    page_type { "MyString" }
    column { 1 }
    row { 1 }
    pillar_count { 1 }
    grid_width { 1.5 }
    grid_height { 1.5 }
    gutter { 1.5 }
    margin { 1.5 }
    layout { "MyText" }
    layout_with_pillar_path { "MyText" }
    like { 1 }
  end
end
