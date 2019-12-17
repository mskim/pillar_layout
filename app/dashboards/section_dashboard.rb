require "administrate/base_dashboard"

class SectionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    publication: Field::BelongsTo,
    page_plan: Field::HasOne,
    articles: Field::HasMany,
    ad_box_templates: Field::HasMany,
    id: Field::Number,
    profile: Field::String,
    column: Field::Number,
    row: Field::Number,
    order: Field::Number,
    ad_type: Field::String,
    is_front_page: Field::Boolean,
    story_count: Field::Number,
    page_number: Field::Number,
    section_name: Field::String,
    color_page: Field::Boolean,
    layout: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    draw_divider: Field::Boolean,
    path: Field::String,
    grid_width: Field::Number.with_options(decimals: 2),
    grid_height: Field::Number.with_options(decimals: 2),
    lines_per_grid: Field::Number.with_options(decimals: 2),
    width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    left_margin: Field::Number.with_options(decimals: 2),
    top_margin: Field::Number.with_options(decimals: 2),
    right_margin: Field::Number.with_options(decimals: 2),
    bottom_margin: Field::Number.with_options(decimals: 2),
    gutter: Field::Number.with_options(decimals: 2),
    page_heading_margin_in_lines: Field::Number,
    article_line_thickness: Field::Number.with_options(decimals: 2),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  publication
  page_plan
  articles
  ad_box_templates
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  publication
  page_plan
  articles
  ad_box_templates
  id
  profile
  column
  row
  order
  ad_type
  is_front_page
  story_count
  page_number
  section_name
  color_page
  layout
  created_at
  updated_at
  draw_divider
  path
  grid_width
  grid_height
  lines_per_grid
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  gutter
  page_heading_margin_in_lines
  article_line_thickness
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  publication
  page_plan
  articles
  ad_box_templates
  profile
  column
  row
  order
  ad_type
  is_front_page
  story_count
  page_number
  section_name
  color_page
  layout
  draw_divider
  path
  grid_width
  grid_height
  lines_per_grid
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  gutter
  page_heading_margin_in_lines
  article_line_thickness
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

  # Overwrite this method to customize how sections are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(section)
  #   "Section ##{section.id}"
  # end
end
