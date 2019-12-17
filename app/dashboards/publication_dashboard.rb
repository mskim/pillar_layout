require "administrate/base_dashboard"

class PublicationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issues: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    unit: Field::String,
    paper_size: Field::String,
    width_in_unit: Field::Number.with_options(decimals: 2),
    height_in_unit: Field::Number.with_options(decimals: 2),
    left_margin_in_unit: Field::Number.with_options(decimals: 2),
    top_margin_in_unit: Field::Number.with_options(decimals: 2),
    right_margin_in_unit: Field::Number.with_options(decimals: 2),
    bottom_margin_in_unit: Field::Number.with_options(decimals: 2),
    gutter_in_unit: Field::Number.with_options(decimals: 2),
    width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    left_margin: Field::Number.with_options(decimals: 2),
    top_margin: Field::Number.with_options(decimals: 2),
    right_margin: Field::Number.with_options(decimals: 2),
    bottom_margin: Field::Number.with_options(decimals: 2),
    gutter: Field::Number.with_options(decimals: 2),
    lines_per_grid: Field::Number,
    page_count: Field::Number,
    section_names: Field::Text,
    page_columns: Field::Text,
    row: Field::Number,
    front_page_heading_height: Field::Number,
    inner_page_heading_height: Field::Number,
    article_bottom_spaces_in_lines: Field::Number,
    article_line_draw_sides: Field::Text,
    article_line_thickness: Field::Number.with_options(decimals: 2),
    draw_divider: Field::Boolean,
    cms_server_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  issues
  id
  name
  unit
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  issues
  id
  name
  unit
  paper_size
  width_in_unit
  height_in_unit
  left_margin_in_unit
  top_margin_in_unit
  right_margin_in_unit
  bottom_margin_in_unit
  gutter_in_unit
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  gutter
  lines_per_grid
  page_count
  section_names
  page_columns
  row
  front_page_heading_height
  inner_page_heading_height
  article_bottom_spaces_in_lines
  article_line_draw_sides
  article_line_thickness
  draw_divider
  cms_server_url
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  issues
  name
  unit
  paper_size
  width_in_unit
  height_in_unit
  left_margin_in_unit
  top_margin_in_unit
  right_margin_in_unit
  bottom_margin_in_unit
  gutter_in_unit
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  gutter
  lines_per_grid
  page_count
  section_names
  page_columns
  row
  front_page_heading_height
  inner_page_heading_height
  article_bottom_spaces_in_lines
  article_line_draw_sides
  article_line_thickness
  draw_divider
  cms_server_url
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

  # Overwrite this method to customize how publications are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(publication)
  #   "Publication ##{publication.id}"
  # end
end
