# frozen_string_literal: true

require 'administrate/base_dashboard'

class PillarDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    working_articles: Field::HasMany,
    id: Field::Number,
    direction: Field::String,
    grid_x: Field::Number,
    grid_y: Field::Number,
    column: Field::Number,
    row: Field::Number,
    order: Field::Number,
    box_count: Field::Number,
    layout_with_pillar_path: Field::Text,
    layout: Field::Text,
    profile: Field::String,
    finger_print: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    working_articles
    id
    direction
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    working_articles
    id
    direction
    grid_x
    grid_y
    column
    row
    order
    box_count
    layout_with_pillar_path
    layout
    profile
    finger_print
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    working_articles
    direction
    grid_x
    grid_y
    column
    row
    order
    box_count
    layout_with_pillar_path
    layout
    profile
    finger_print
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

  # Overwrite this method to customize how pillars are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pillar)
  #   "Pillar ##{pillar.id}"
  # end
end
