require "administrate/base_dashboard"

class AnnouncementDashboard < Administrate::BaseDashboard
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
    kind: Field::String,
    title: Field::String,
    subtitle: Field::String,
    page_column: Field::Number,
    column: Field::Number,
    lines: Field::Number,
    page: Field::Number,
    color: Field::String,
    script: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
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
  kind
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  publication
  id
  name
  kind
  title
  subtitle
  page_column
  column
  lines
  page
  color
  script
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  publication
  name
  kind
  title
  subtitle
  page_column
  column
  lines
  page
  color
  script
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

  # Overwrite this method to customize how announcements are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(announcement)
  #   "Announcement ##{announcement.id}"
  # end
end
