# == Schema Information
#
# Table name: stories
#
#  id                 :bigint           not null, primary key
#  backup             :text
#  body               :string
#  by_line            :string
#  category_code      :string
#  category_name      :string
#  char_count         :integer
#  date               :date
#  for_front_page     :boolean
#  group              :string
#  image_name         :string
#  kind               :string
#  order              :integer
#  path               :string
#  price              :float
#  published          :boolean
#  quote              :string
#  reporter           :string
#  selected           :boolean
#  status             :string
#  story_type         :string           default("0")
#  subject_head       :string
#  subtitle           :string
#  summitted          :boolean
#  summitted_at       :time
#  summitted_section  :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  working_article_id :bigint
#
# Indexes
#
#  index_stories_on_user_id             (user_id)
#  index_stories_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (working_article_id => working_articles.id)
#

FactoryBot.define do
  factory :story do
    user { nil }
    working_article { nil }
    reporter { "MyString" }
    group { "MyString" }
    date { "2018-09-29" }
    title { "MyString" }
    subtitle { "MyString" }
    body { "MyString" }
    quote { "MyString" }
    status { "MyString" }
    char_count { 1 }
    published { false }
    path { "MyString" }
  end
end
