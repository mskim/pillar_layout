require "administrate/base_dashboard"

class StoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    working_article: Field::BelongsTo,
    rich_text_content: Field::HasOne,
    id: Field::Number,
    date: Field::DateTime,
    reporter: Field::String,
    group: Field::String,
    title: Field::String,
    subtitle: Field::String,
    quote: Field::String,
    body: Field::String,
    char_count: Field::Number,
    status: Field::String,
    for_front_page: Field::Boolean,
    summitted: Field::Boolean,
    selected: Field::Boolean,
    published: Field::Boolean,
    summitted_at: Field::Time,
    path: Field::String,
    order: Field::Number,
    image_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    summitted_section: Field::String,
    category_code: Field::String,
    price: Field::Number.with_options(decimals: 2),
    backup: Field::Text,
    subject_head: Field::String,
    kind: Field::String,
    by_line: Field::String,
    category_name: Field::String,
    story_type: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  user
  working_article
  rich_text_content
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  user
  working_article
  rich_text_content
  id
  date
  reporter
  group
  title
  subtitle
  quote
  body
  char_count
  status
  for_front_page
  summitted
  selected
  published
  summitted_at
  path
  order
  image_name
  created_at
  updated_at
  summitted_section
  category_code
  price
  backup
  subject_head
  kind
  by_line
  category_name
  story_type
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  user
  working_article
  rich_text_content
  date
  reporter
  group
  title
  subtitle
  quote
  body
  char_count
  status
  for_front_page
  summitted
  selected
  published
  summitted_at
  path
  order
  image_name
  summitted_section
  category_code
  price
  backup
  subject_head
  kind
  by_line
  category_name
  story_type
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

  # Overwrite this method to customize how stories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(story)
  #   "Story ##{story.id}"
  # end
end
