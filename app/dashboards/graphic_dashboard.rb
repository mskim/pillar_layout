# frozen_string_literal: true

require 'administrate/base_dashboard'
require 'active_storage'

class GraphicDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issue: Field::BelongsTo,
    working_article: Field::BelongsTo,
    storage_graphic_attachment: Field::ActiveStorage,
    storage_graphic_blob: Field::HasOne,
    id: Field::Number,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    extra_height_in_lines: Field::Number,
    graphic: Field::String,
    caption: Field::String,
    source: Field::String,
    position: Field::String,
    page_number: Field::Number,
    story_number: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    x_grid: Field::Number,
    y_in_lines: Field::Number,
    height_in_lines: Field::Number,
    draw_frame: Field::Boolean,
    detail_mode: Field::Boolean,
    zoom_level: Field::Number,
    zoom_direction: Field::Number,
    move_level: Field::Number,
    sub_grid_size: Field::String,
    fit_type: Field::String,
    title: Field::String,
    description: Field::Text,
    reporter_graphic_path: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    issue
    working_article
    storage_graphic_attachment
    storage_graphic_blob
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    issue
    working_article
    storage_graphic_attachment
    storage_graphic_blob
    id
    grid_x
    grid_y
    column
    row
    extra_height_in_lines
    graphic
    caption
    source
    position
    page_number
    story_number
    created_at
    updated_at
    x_grid
    y_in_lines
    height_in_lines
    draw_frame
    detail_mode
    zoom_level
    zoom_direction
    move_level
    sub_grid_size
    fit_type
    title
    description
    reporter_graphic_path
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    issue
    working_article
    storage_graphic_attachment
    storage_graphic_blob
    grid_x
    grid_y
    column
    row
    extra_height_in_lines
    graphic
    caption
    source
    position
    page_number
    story_number
    x_grid
    y_in_lines
    height_in_lines
    draw_frame
    detail_mode
    zoom_level
    zoom_direction
    move_level
    sub_grid_size
    fit_type
    title
    description
    reporter_graphic_path
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

  # Overwrite this method to customize how graphics are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(graphic)
  #   "Graphic ##{graphic.id}"
  # end
end
