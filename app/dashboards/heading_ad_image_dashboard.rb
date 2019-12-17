require "administrate/base_dashboard"

class HeadingAdImageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    page_heading: Field::BelongsTo,
    id: Field::Number,
    heading_ad_image: Field::String,
    x: Field::Number.with_options(decimals: 2),
    y: Field::Number.with_options(decimals: 2),
    width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    x_in_unit: Field::Number.with_options(decimals: 2),
    y_in_unit: Field::Number.with_options(decimals: 2),
    width_in_unit: Field::Number.with_options(decimals: 2),
    height_in_unit: Field::Number.with_options(decimals: 2),
    advertiser: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    date: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  page_heading
  id
  heading_ad_image
  x
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  page_heading
  id
  heading_ad_image
  x
  y
  width
  height
  x_in_unit
  y_in_unit
  width_in_unit
  height_in_unit
  advertiser
  created_at
  updated_at
  date
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  page_heading
  heading_ad_image
  x
  y
  width
  height
  x_in_unit
  y_in_unit
  width_in_unit
  height_in_unit
  advertiser
  date
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

  # Overwrite this method to customize how heading ad images are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(heading_ad_image)
  #   "HeadingAdImage ##{heading_ad_image.id}"
  # end
end
