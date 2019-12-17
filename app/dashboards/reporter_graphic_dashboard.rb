require "administrate/base_dashboard"

class ReporterGraphicDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    uploads_attachments: Field::HasMany.with_options(class_name: "ActiveStorage::Attachment"),
    uploads_blobs: Field::HasMany.with_options(class_name: "ActiveStorage::Blob"),
    finished_job_attachment: Field::HasOne,
    finished_job_blob: Field::HasOne,
    id: Field::Number,
    title: Field::String,
    caption: Field::String,
    source: Field::String,
    wire_pictures: Field::String,
    section_name: Field::String,
    used_in_layout: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    column: Field::Number,
    row: Field::Number,
    extra_height: Field::Number,
    status: Field::String,
    designer: Field::String,
    request: Field::Text,
    data: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  user
  uploads_attachments
  uploads_blobs
  finished_job_attachment
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  user
  uploads_attachments
  uploads_blobs
  finished_job_attachment
  finished_job_blob
  id
  title
  caption
  source
  wire_pictures
  section_name
  used_in_layout
  created_at
  updated_at
  column
  row
  extra_height
  status
  designer
  request
  data
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  user
  uploads_attachments
  uploads_blobs
  finished_job_attachment
  finished_job_blob
  title
  caption
  source
  wire_pictures
  section_name
  used_in_layout
  column
  row
  extra_height
  status
  designer
  request
  data
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

  # Overwrite this method to customize how reporter graphics are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(reporter_graphic)
  #   "ReporterGraphic ##{reporter_graphic.id}"
  # end
end
