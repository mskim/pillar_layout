# frozen_string_literal: true

require 'administrate/base_dashboard'

class PageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issue: Field::BelongsTo,
    page_plan: Field::BelongsTo,
    pillars: Field::HasMany,
    working_articles: Field::HasMany,
    ad_boxes: Field::HasMany,
    page_heading: Field::HasOne,
    id: Field::Number,
    page_number: Field::Number,
    section_name: Field::String,
    column: Field::Number,
    row: Field::Number,
    ad_type: Field::String,
    story_count: Field::Number,
    color_page: Field::Boolean,
    profile: Field::String,
    template_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    clone_name: Field::String,
    slug: Field::String,
    layout: Field::Text,
    publication_id: Field::Number,
    path: Field::String,
    date: Field::DateTime,
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
    article_line_thickness: Field::Number.with_options(decimals: 2),
    page_heading_margin_in_lines: Field::Number,
    tag: Field::String,
    display_name: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    ad_type
    issue
    pillars
    column
    working_articles
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    issue
    page_plan
    pillars
    working_articles
    ad_boxes
    page_heading
    page_number
    section_name
    column
    row
    ad_type
    story_count
    color_page
    profile
    template_id
    created_at
    updated_at
    clone_name
    slug
    layout
    publication_id
    path
    date
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
    article_line_thickness
    page_heading_margin_in_lines
    tag
    display_name
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    issue
    page_plan
    pillars
    working_articles
    ad_boxes
    page_heading
    page_number
    section_name
    column
    row
    ad_type
    story_count
    color_page
    profile
    template_id
    clone_name
    slug
    layout
    publication_id
    path
    date
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
    article_line_thickness
    page_heading_margin_in_lines
    tag
    display_name
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

  # Overwrite this method to customize how pages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(page)
  #   "Page ##{page.id}"
  # end
end
