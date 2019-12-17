require "administrate/base_dashboard"

class BodyLineDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    working_aticle: Field::BelongsTo,
    id: Field::Number,
    order: Field::Number,
    x: Field::Number.with_options(decimals: 2),
    y: Field::Number.with_options(decimals: 2),
    width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    coulumn: Field::Number,
    line_number: Field::Number,
    tokens: Field::Text,
    kind: Field::Number,
    working_article_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  working_aticle
  id
  order
  x
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  working_aticle
  id
  order
  x
  y
  width
  height
  coulumn
  line_number
  tokens
  kind
  working_article_id
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  working_aticle
  order
  x
  y
  width
  height
  coulumn
  line_number
  tokens
  kind
  working_article_id
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

  # Overwrite this method to customize how body lines are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(body_line)
  #   "BodyLine ##{body_line.id}"
  # end
end
