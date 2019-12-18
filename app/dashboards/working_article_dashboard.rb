# frozen_string_literal: true

require 'administrate/base_dashboard'

class WorkingArticleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    page: Field::BelongsTo,
    pillar: Field::BelongsTo,
    article: Field::BelongsTo,
    proofs: Field::HasMany,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    order: Field::Number,
    kind: Field::String,
    profile: Field::String,
    title: Field::Text,
    title_head: Field::String,
    subtitle: Field::Text,
    subtitle_head: Field::String,
    body: Field::Text,
    reporter: Field::String,
    email: Field::String,
    image: Field::String,
    quote: Field::Text,
    subject_head: Field::String,
    on_left_edge: Field::Boolean,
    on_right_edge: Field::Boolean,
    is_front_page: Field::Boolean,
    top_story: Field::Boolean,
    top_position: Field::Boolean,
    inactive: Field::Boolean,
    extended_line_count: Field::Number,
    pushed_line_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    quote_box_size: Field::Number,
    category_code: Field::Number,
    slug: Field::String,
    publication_name: Field::String,
    path: Field::String,
    date: Field::DateTime,
    page_number: Field::Number,
    page_heading_margin_in_lines: Field::Number,
    grid_width: Field::Number.with_options(decimals: 2),
    grid_height: Field::Number.with_options(decimals: 2),
    gutter: Field::Number.with_options(decimals: 2),
    has_profile_image: Field::Boolean,
    announcement_text: Field::String,
    announcement_column: Field::Number,
    announcement_color: Field::String,
    boxed_subtitle_type: Field::Number,
    boxed_subtitle_text: Field::String,
    subtitle_type: Field::String,
    overlap: Field::Text,
    embedded: Field::Boolean,
    heading_columns: Field::Number,
    quote_position: Field::Number,
    quote_x_grid: Field::Number,
    quote_v_extra_space: Field::Number,
    quote_alignment: Field::String,
    quote_line_type: Field::String,
    quote_box_column: Field::Number,
    quote_box_type: Field::Number,
    quote_box_show: Field::Boolean,
    y_in_lines: Field::Number,
    height_in_lines: Field::Number,
    by_line: Field::String,
    price: Field::Number.with_options(decimals: 2),
    left_line: Field::Number,
    top_line: Field::Number,
    right_line: Field::Number,
    bottom_line: Field::Number,
    category_name: Field::String,
    subcategory_code: Field::String,
    pillar_order: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    page
    pillar
    title
    subtitle
    body
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    page
    pillar
    article
    proofs
    grid_x
    grid_y
    column
    row
    order
    kind
    profile
    title
    title_head
    subtitle
    subtitle_head
    body
    reporter
    email
    quote
    subject_head
    on_left_edge
    on_right_edge
    is_front_page
    top_story
    top_position
    inactive
    extended_line_count
    pushed_line_count
    created_at
    updated_at
    quote_box_size
    category_code
    slug
    publication_name
    path
    date
    page_number
    page_heading_margin_in_lines
    grid_width
    grid_height
    gutter
    has_profile_image
    announcement_text
    announcement_column
    announcement_color
    boxed_subtitle_type
    boxed_subtitle_text
    subtitle_type
    overlap
    embedded
    heading_columns
    quote_position
    quote_x_grid
    quote_v_extra_space
    quote_alignment
    quote_line_type
    quote_box_column
    quote_box_type
    quote_box_show
    y_in_lines
    height_in_lines
    by_line
    price
    left_line
    top_line
    right_line
    bottom_line
    category_name
    subcategory_code
    pillar_order
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    page
    pillar
    article
    proofs
    grid_x
    grid_y
    column
    row
    order
    kind
    profile
    title
    title_head
    subtitle
    subtitle_head
    body
    reporter
    email
    quote
    subject_head
    on_left_edge
    on_right_edge
    is_front_page
    top_story
    top_position
    inactive
    extended_line_count
    pushed_line_count
    quote_box_size
    category_code
    slug
    publication_name
    path
    date
    page_number
    page_heading_margin_in_lines
    grid_width
    grid_height
    gutter
    has_profile_image
    announcement_text
    announcement_column
    announcement_color
    boxed_subtitle_type
    boxed_subtitle_text
    subtitle_type
    overlap
    embedded
    heading_columns
    quote_position
    quote_x_grid
    quote_v_extra_space
    quote_alignment
    quote_line_type
    quote_box_column
    quote_box_type
    quote_box_show
    y_in_lines
    height_in_lines
    by_line
    price
    left_line
    top_line
    right_line
    bottom_line
    category_name
    subcategory_code
    pillar_order
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

  # Overwrite this method to customize how working articles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(working_article)
  #   "WorkingArticle ##{working_article.id}"
  # end
end
