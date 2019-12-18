# frozen_string_literal: true

require 'administrate/base_dashboard'

class IssueDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    publication: Field::BelongsTo,
    page_plans: Field::HasMany,
    pages: Field::HasMany,
    spread: Field::HasOne,
    images: Field::HasMany,
    ad_images: Field::HasMany,
    id: Field::Number,
    date: Field::DateTime,
    number: Field::String,
    plan: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    slug: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    date
    number
    page_plans
    pages
    spread
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    publication
    pages
    spread
    images
    ad_images
    date
    number
    plan
    created_at
    updated_at
    slug
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    publication
    page_plans
    pages
    spread
    images
    ad_images
    date
    number
    plan
    slug
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

  # Overwrite this method to customize how issues are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(issue)
  #   "Issue ##{issue.id}"
  # end
end
