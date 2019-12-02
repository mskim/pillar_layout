# == Schema Information
#
# Table name: announcements
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  kind           :string
#  title          :string
#  subtitle       :string
#  page_column    :integer
#  column         :integer
#  lines          :integer
#  page           :integer
#  color          :string
#  script         :text
#  publication_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_announcements_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

FactoryBot.define do
  factory :announcement do
    name { "MyString" }
    kind { "MyString" }
    title { "MyString" }
    subtitle { "MyString" }
    column { 1 }
    lines { 1 }
    page { 1 }
    color { "MyString" }
    script { "MyText" }
    publication { nil }
  end
end
