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

require 'rails_helper'

RSpec.describe Paragraph, type: :model do
  string = "This is some sample text."
  subject {Paragraph.create(para_text: string)}

  it 'shuld create Paragraph' do
    expect(subject.class).to eq(Paragraph)
  end

  it 'shuld create tokens' do
    expect(subject.tokens.class).to eq(Array)
    expect(subject.tokens.length).to eq(5)
  end
end
