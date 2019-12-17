require "administrate/base_dashboard"

class TextStyleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    publication: Field::BelongsTo,
    id: Field::Number,
    korean_name: Field::String,
    english: Field::String,
    category: Field::String,
    font_family: Field::String,
    font: Field::String,
    font_size: Field::Number.with_options(decimals: 2),
    text_color: Field::String,
    alignment: Field::String,
    tracking: Field::Number.with_options(decimals: 2),
    space_width: Field::Number.with_options(decimals: 2),
    scale: Field::Number.with_options(decimals: 2),
    text_line_spacing: Field::Number.with_options(decimals: 2),
    space_before_in_lines: Field::Number,
    space_after_in_lines: Field::Number,
    text_height_in_lines: Field::Number,
    box_attributes: Field::Text,
    markup: Field::String,
    graphic_attributes: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    first_line_indent: Field::Number.with_options(decimals: 2),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  publication
  id
  korean_name
  english
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  publication
  id
  korean_name
  english
  category
  font_family
  font
  font_size
  text_color
  alignment
  tracking
  space_width
  scale
  text_line_spacing
  space_before_in_lines
  space_after_in_lines
  text_height_in_lines
  box_attributes
  markup
  graphic_attributes
  created_at
  updated_at
  first_line_indent
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  publication
  korean_name
  english
  category
  font_family
  font
  font_size
  text_color
  alignment
  tracking
  space_width
  scale
  text_line_spacing
  space_before_in_lines
  space_after_in_lines
  text_height_in_lines
  box_attributes
  markup
  graphic_attributes
  first_line_indent
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

  # Overwrite this method to customize how text styles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(text_style)
  #   "TextStyle ##{text_style.id}"
  # end
end
