# == Schema Information
#
# Table name: line_fragments
#
#  id                 :bigint           not null, primary key
#  column             :integer
#  height             :float
#  line_type          :string
#  order              :integer
#  text_area_width    :float
#  text_area_x        :float
#  tokens             :text
#  width              :float
#  x                  :float
#  y                  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  paragraph_id       :bigint
#  working_article_id :bigint
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
