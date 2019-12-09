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

require 'rails_helper'

RSpec.describe BodyLine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
