# == Schema Information
#
# Table name: yh_articles
#
#  id              :bigint(8)        not null, primary key
#  action          :string
#  service_type    :string
#  content_id      :string
#  date            :date
#  time            :string
#  urgency         :string
#  category        :string
#  class_code      :string
#  attriubute_code :string
#  source          :string
#  credit          :string
#  region          :string
#  title           :string
#  body            :text
#  writer          :string
#  char_count      :integer
#  taken_by        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_name   :string
#  category_code   :string
#

FactoryBot.define do
  factory :yh_article do
    action { "MyString" }
    service_type { "MyString" }
    content_id { "MyString" }
    date { "2019-02-20" }
    time { "MyString" }
    urgency { "MyString" }
    category { "MyString" }
    class_code { "MyString" }
    attriubute_code { "MyString" }
    source { "MyString" }
    credit { "MyString" }
    region { "MyString" }
    title { "MyString" }
    body { "MyText" }
    writer { "MyString" }
    char_count { 1 }
    taken_by { "MyString" }
  end
end
