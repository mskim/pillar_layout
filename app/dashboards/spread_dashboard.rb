require "administrate/base_dashboard"

class SpreadDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issue: Field::BelongsTo,
    id: Field::Number,
    left_page_id: Field::Number,
    right_page_id: Field::Number,
    ad_box_id: Field::Number,
    color_page: Field::Boolean,
    width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    left_margin: Field::Number.with_options(decimals: 2),
    top_margin: Field::Number.with_options(decimals: 2),
    right_margin: Field::Number.with_options(decimals: 2),
    bottom_margin: Field::Number.with_options(decimals: 2),
    page_gutter: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  issue
  id
  left_page_id
  right_page_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  issue
  id
  left_page_id
  right_page_id
  ad_box_id
  color_page
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  page_gutter
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  issue
  left_page_id
  right_page_id
  ad_box_id
  color_page
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  page_gutter
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

  # Overwrite this method to customize how spreads are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(spread)
  #   "Spread ##{spread.id}"
  # end
end
