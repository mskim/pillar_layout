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
