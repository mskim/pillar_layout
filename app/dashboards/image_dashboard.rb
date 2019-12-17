require "administrate/base_dashboard"

class ImageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issue: Field::BelongsTo,
    working_article: Field::BelongsTo,
    storage_image_attachment: Field::HasOne,
    storage_image_blob: Field::HasOne,
    id: Field::Number,
    column: Field::Number,
    row: Field::Number,
    extra_height_in_lines: Field::Number,
    image: Field::String,
    caption_title: Field::String,
    caption: Field::String,
    source: Field::String,
    position: Field::Number,
    page_number: Field::Number,
    story_number: Field::Number,
    landscape: Field::Boolean,
    used_in_layout: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    extra_line: Field::Number,
    x_grid: Field::Number,
    y_in_lines: Field::Number,
    height_in_lines: Field::Number,
    draw_frame: Field::Boolean,
    zoom_level: Field::Number,
    zoom_direction: Field::Number,
    move_level: Field::Number,
    auto_size: Field::Number,
    fit_type: Field::String,
    image_kind: Field::String,
    not_related: Field::Boolean,
    reporter_image_path: Field::String,
    crop_x: Field::Number,
    crop_y: Field::Number,
    crop_w: Field::Number,
    crop_h: Field::Number,
    left_line: Field::Number,
    top_line: Field::Number,
    right_line: Field::Number,
    bottom_line: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  issue
  working_article
  storage_image_attachment
  storage_image_blob
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  issue
  working_article
  storage_image_attachment
  storage_image_blob
  id
  column
  row
  extra_height_in_lines
  image
  caption_title
  caption
  source
  position
  page_number
  story_number
  landscape
  used_in_layout
  created_at
  updated_at
  extra_line
  x_grid
  y_in_lines
  height_in_lines
  draw_frame
  zoom_level
  zoom_direction
  move_level
  auto_size
  fit_type
  image_kind
  not_related
  reporter_image_path
  crop_x
  crop_y
  crop_w
  crop_h
  left_line
  top_line
  right_line
  bottom_line
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  issue
  working_article
  storage_image_attachment
  storage_image_blob
  column
  row
  extra_height_in_lines
  image
  caption_title
  caption
  source
  position
  page_number
  story_number
  landscape
  used_in_layout
  extra_line
  x_grid
  y_in_lines
  height_in_lines
  draw_frame
  zoom_level
  zoom_direction
  move_level
  auto_size
  fit_type
  image_kind
  not_related
  reporter_image_path
  crop_x
  crop_y
  crop_w
  crop_h
  left_line
  top_line
  right_line
  bottom_line
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

  # Overwrite this method to customize how images are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(image)
  #   "Image ##{image.id}"
  # end
end
