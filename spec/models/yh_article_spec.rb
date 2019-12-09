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

require 'rails_helper'

RSpec.describe YhArticle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
