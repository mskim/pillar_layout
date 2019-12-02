# == Schema Information
#
# Table name: yh_pictures
#
#  id              :bigint(8)        not null, primary key
#  action          :string
#  service_type    :string
#  content_id      :string
#  date            :date
#  time            :time
#  urgency         :string
#  category        :string
#  class_code      :string
#  attriubute_code :string
#  source          :string
#  credit          :string
#  region          :string
#  title           :string
#  comment         :string
#  body            :string
#  picture         :string
#  taken_by        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :yh_picture do
    action { "MyString" }
    service_type { "MyString" }
    content_id { "MyString" }
    date { "2019-02-20" }
    time { "2019-02-20 05:11:00" }
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
    file_name { "MyString" }
    taken_by { "MyString" }
  end
end
