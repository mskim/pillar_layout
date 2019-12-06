# == Schema Information
#
# Table name: reporter_images
#
#  id             :bigint           not null, primary key
#  caption        :string
#  kind           :string
#  reporter_image :string
#  section_name   :string
#  source         :string
#  title          :string
#  used_in_layout :boolean
#  wire_pictures  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_reporter_images_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :reporter_image do
    user { nil }
    title { "MyString" }
    caption { "MyString" }
    source { "MyString" }
    reporter_image { "MyString" }
  end
end
