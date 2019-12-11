# == Schema Information
#
# Table name: yh_graphics
#
#  id              :bigint           not null, primary key
#  action          :string
#  attriubute_code :string
#  body            :string
#  category        :string
#  class_code      :string
#  comment         :string
#  credit          :string
#  date            :date
#  region        :string
#  picture         :string
#  service_type    :string
#  source          :string
#  taken_by        :string
#  time            :time
#  title           :string
#  urgency         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :string
#

FactoryBot.define do
  factory :yh_graphic do
    action { "MyString" }
    service_type { "MyString" }
    content_id { "MyString" }
    date { "2019-03-12" }
    time { "2019-03-12 14:59:03" }
    urgency { "MyString" }
    category { "MyString" }
    class_code { "MyString" }
    attriubute_code { "MyString" }
    source { "MyString" }
    credit { "MyString" }
    region { "MyString" }
    title { "MyString" }
    comment { "MyString" }
    body { "MyString" }
    picture { "MyString" }
    taken_by { "MyString" }
  end
end
