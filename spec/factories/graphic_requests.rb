# == Schema Information
#
# Table name: graphic_requests
#
#  id          :bigint           not null, primary key
#  column      :integer
#  data        :text
#  date        :date
#  designer    :string
#  page_column :integer
#  request     :text
#  row         :integer
#  status      :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_graphic_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :graphic_request do
    date { "2019-02-20" }
    user { nil }
    designer { "MyString" }
    request { "MyText" }
    data { "MyText" }
    status { 1 }
  end
end
