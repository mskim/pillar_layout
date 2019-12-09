# == Schema Information
#
# Table name: body_lines
#
#  id                 :bigint           not null, primary key
#  coulumn            :integer
#  height             :float
#  kind               :integer
#  line_number        :integer
#  order              :integer
#  tokens             :text
#  width              :float
#  x                  :float
#  y                  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint           not null
#
# Indexes
#
#  index_body_lines_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

FactoryBot.define do
  factory :body_line do
    order { 1 }
    x { 1.5 }
    y { "" }
    width { 1.5 }
    height { 1.5 }
    coulumn { 1 }
    line_number { 1 }
    tokens { "MyText" }
    overflow { "" }
    working_aticle { nil }
  end
end
