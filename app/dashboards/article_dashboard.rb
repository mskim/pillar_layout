require "administrate/base_dashboard"

class ArticleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    section: Field::BelongsTo,
    images: Field::HasMany,
    id: Field::Number,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    order: Field::Number,
    kind: Field::String,
    profile: Field::Number,
    title_head: Field::String,
    title: Field::Text,
    subtitle: Field::Text,
    subtitle_head: Field::Text,
    body: Field::Text,
    reporter: Field::String,
    email: Field::String,
    personal_image: Field::String,
    image: Field::String,
    quote: Field::Text,
    subject_head: Field::String,
    on_left_edge: Field::Boolean,
    on_right_edge: Field::Boolean,
    is_front_page: Field::Boolean,
    top_story: Field::Boolean,
    top_position: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    extended_line_count: Field::Number,
    pushed_line_count: Field::Number,
    publication_name: Field::String,
    path: Field::String,
    page_heading_margin_in_lines: Field::Number,
    grid_width: Field::Number.with_options(decimals: 2),
    grid_height: Field::Number.with_options(decimals: 2),
    gutter: Field::Number.with_options(decimals: 2),
    overlap: Field::Text,
    embedded: Field::Boolean,
    y_in_lines: Field::Number,
    height_in_lines: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  section
  images
  id
  grid_x
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  section
  images
  id
  grid_x
  grid_y
  column
  row
  order
  kind
  profile
  title_head
  title
  subtitle
  subtitle_head
  body
  reporter
  email
  personal_image
  image
  quote
  subject_head
  on_left_edge
  on_right_edge
  is_front_page
  top_story
  top_position
  created_at
  updated_at
  extended_line_count
  pushed_line_count
  publication_name
  path
  page_heading_margin_in_lines
  grid_width
  grid_height
  gutter
  overlap
  embedded
  y_in_lines
  height_in_lines
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  section
  images
  grid_x
  grid_y
  column
  row
  order
  kind
  profile
  title_head
  title
  subtitle
  subtitle_head
  body
  reporter
  email
  personal_image
  image
  quote
  subject_head
  on_left_edge
  on_right_edge
  is_front_page
  top_story
  top_position
  extended_line_count
  pushed_line_count
  publication_name
  path
  page_heading_margin_in_lines
  grid_width
  grid_height
  gutter
  overlap
  embedded
  y_in_lines
  height_in_lines
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

  # Overwrite this method to customize how articles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(article)
  #   "Article ##{article.id}"
  # end
end
