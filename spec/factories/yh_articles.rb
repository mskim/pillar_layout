# == Schema Information
#
# Table name: yh_articles
#
#  id              :bigint           not null, primary key
#  action          :string
#  attriubute_code :string
#  body            :text
#  category        :string
#  category_code   :string
#  category_name   :string
#  char_count      :integer
#  class_code      :string
#  credit          :string
#  date            :date
#  page_ref        :string
#  service_type    :string
#  source          :string
#  taken_by        :string
#  time            :string
#  title           :string
#  urgency         :string
#  writer          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :string
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
    page_ref { "MyString" }
    title { "MyString" }
    body { "MyText" }
    writer { "MyString" }
    char_count { 1 }
    taken_by { "MyString" }
  end
end
