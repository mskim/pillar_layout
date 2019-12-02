FactoryBot.define do
  factory :layout_node do
    direction { "MyString" }
    grid_x { 1 }
    grid_y { 1 }
    column { 1 }
    row { 1 }
    profile { "MyString" }
    node_kind { "MyString" }
    tag { "MyString" }
    selected { false }
    actions { "MyText" }
    layout { "MyText" }
    layout_with_pillar_path { "MyText" }
    box_count { 1 }
  end
end
