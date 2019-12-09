# == Schema Information
#
# Table name: yh_pictures
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
#  page_ref        :string
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
    page_ref { "MyString" }
    title { "MyString" }
    comment { "MyString" }
    body { "MyString" }
    file_name { "MyString" }
    taken_by { "MyString" }
  end
end
