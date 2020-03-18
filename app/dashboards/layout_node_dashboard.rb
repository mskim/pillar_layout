require "administrate/base_dashboard"

class LayoutNodeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    direction: Field::String,
    ancestry: Field::String,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    node_kind: Field::String,
    order: Field::Number,
    tag: Field::String,
    selected: Field::Boolean,
    actions: Field::Text,
    layout_with_pillar_path: Field::Text,
    box_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  direction
  ancestry
  grid_x
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  direction
  ancestry
  grid_x
  grid_y
  column
  row
  profile
  node_kind
  order
  tag
  selected
  actions
  layout
  layout_with_pillar_path
  box_count
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  direction
  ancestry
  grid_x
  grid_y
  column
  row
  profile
  node_kind
  order
  tag
  selected
  actions
  layout
  layout_with_pillar_path
  box_count
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how layout nodes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(layout_node)
  #   "LayoutNode ##{layout_node.id}"
  # end
end
