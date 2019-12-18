# frozen_string_literal: true

require 'administrate/base_dashboard'

class AdBoxDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    page: Field::BelongsTo,
    spread: Field::BelongsTo,
    storage_ad_image_attachment: Field::HasOne,
    storage_ad_image_blob: Field::HasOne,
    id: Field::Number,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    order: Field::Number,
    ad_type: Field::String,
    advertiser: Field::String,
    inactive: Field::Boolean,
    ad_image: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    color: Field::Boolean,
    path: Field::String,
    date: Field::DateTime,
    page_heading_margin_in_lines: Field::Number,
    page_number: Field::Number,
    grid_width: Field::Number.with_options(decimals: 2),
    grid_height: Field::Number.with_options(decimals: 2),
    gutter: Field::Number.with_options(decimals: 2)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    page
    grid_x
    grid_y
    column
    row
    order
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    page
    grid_x
    grid_y
    column
    row
    order
    ad_type
    advertiser
    inactive
    ad_image
    created_at
    updated_at
    color
    path
    date
    page_heading_margin_in_lines
    page_number
    grid_width
    grid_height
    gutter
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    page
    grid_x
    grid_y
    column
    row
    order
    ad_type
    advertiser
    inactive
    ad_image
    color
    path
    date
    page_heading_margin_in_lines
    page_number
    grid_width
    grid_height
    gutter
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

  # Overwrite this method to customize how ad boxes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(ad_box)
  #   "AdBox ##{ad_box.id}"
  # end
end
