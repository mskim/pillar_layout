# == Schema Information
#
# Table name: line_fragments
#
#  id                 :bigint(8)        not null, primary key
#  working_article_id :bigint(8)
#  paragraph_id       :bigint(8)
#  order              :integer
#  column             :integer
#  line_type          :string
#  x                  :float
#  y                  :float
#  width              :float
#  height             :float
#  tokens             :text
#  text_area_x        :float
#  text_area_width    :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_line_fragments_on_paragraph_id        (paragraph_id)
#  index_line_fragments_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (paragraph_id => paragraphs.id)
#  fk_rails_...  (working_article_id => working_articles.id)
#

class LineFragment < ApplicationRecord
  belongs_to :working_article
  belongs_to :paragraph

  def next_line

  end

  def draw_pdf(canvas)

  end
  
end
