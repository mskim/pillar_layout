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
