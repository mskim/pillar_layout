require "administrate/base_dashboard"

class PagePlanDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    issue: Field::BelongsTo,
    page: Field::HasOne,
    article_plans: Field::HasMany,
    id: Field::Number,
    page_number: Field::Number,
    section_name: Field::String,
    selected_template_id: Field::Number,
    column: Field::Number,
    row: Field::Number,
    story_count: Field::Number,
    profile: Field::String,
    ad_type: Field::String,
    advertiser: Field::String,
    color_page: Field::Boolean,
    dirty: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    description: Field::Text,
    deadline: Field::String,
    display_name: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  issue
  page
  article_plans
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  issue
  page
  article_plans
  id
  page_number
  section_name
  selected_template_id
  column
  row
  story_count
  profile
  ad_type
  advertiser
  color_page
  dirty
  created_at
  updated_at
  description
  deadline
  display_name
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  issue
  page
  article_plans
  page_number
  section_name
  selected_template_id
  column
  row
  story_count
  profile
  ad_type
  advertiser
  color_page
  dirty
  description
  deadline
  display_name
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

  # Overwrite this method to customize how page plans are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(page_plan)
  #   "PagePlan ##{page_plan.id}"
  # end
end
