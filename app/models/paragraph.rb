# == Schema Information
#
# Table name: paragraphs
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  working_article_id :bigint(8)
#  order              :integer
#  para_text          :text
#  tokens             :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_paragraphs_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

# tokens are list of Arrays
# [string, width, options={}]
# 


class Paragraph < ApplicationRecord
  belongs_to :working_article
  serialize :tokens, Array
  before_create :create_tokens

  def create_tokens
    bindin.pry
    tokens = []
    words_list = para_text.split(" ")
    words_list.each do |word|
      tokens << {word => word.count * 5}
    end
  end

  def layout_lines(starting_line)

  end

end
