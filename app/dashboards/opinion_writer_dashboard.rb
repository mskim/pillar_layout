require "administrate/base_dashboard"

class OpinionWriterDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    publication: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    title: Field::String,
    work: Field::String,
    position: Field::String,
    email: Field::String,
    cell: Field::String,
    opinion_image: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    category_code: Field::Number,
    opinion_jpg_image: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  publication
  id
  name
  title
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  publication
  id
  name
  title
  work
  position
  email
  cell
  opinion_image
  created_at
  updated_at
  category_code
  opinion_jpg_image
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  publication
  name
  title
  work
  position
  email
  cell
  opinion_image
  category_code
  opinion_jpg_image
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

  # Overwrite this method to customize how opinion writers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(opinion_writer)
  #   "OpinionWriter ##{opinion_writer.id}"
  # end
end
