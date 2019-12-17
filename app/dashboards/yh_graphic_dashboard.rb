require "administrate/base_dashboard"

class YhGraphicDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    action: Field::String,
    service_type: Field::String,
    content_id: Field::String,
    date: Field::DateTime,
    time: Field::Time,
    urgency: Field::String,
    category: Field::String,
    class_code: Field::String,
    attriubute_code: Field::String,
    source: Field::String,
    credit: Field::String,
    region: Field::String,
    title: Field::String,
    comment: Field::String,
    body: Field::String,
    picture: Field::String,
    taken_by: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  action
  service_type
  content_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  action
  service_type
  content_id
  date
  time
  urgency
  category
  class_code
  attriubute_code
  source
  credit
  region
  title
  comment
  body
  picture
  taken_by
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  action
  service_type
  content_id
  date
  time
  urgency
  category
  class_code
  attriubute_code
  source
  credit
  region
  title
  comment
  body
  picture
  taken_by
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

  # Overwrite this method to customize how yh graphics are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(yh_graphic)
  #   "YhGraphic ##{yh_graphic.id}"
  # end
end
