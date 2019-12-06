# == Schema Information
#
# Table name: announcements
#
#  id             :bigint           not null, primary key
#  color          :string
#  column         :integer
#  kind           :string
#  lines          :integer
#  name           :string
#  page           :integer
#  page_column    :integer
#  script         :text
#  subtitle       :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
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
