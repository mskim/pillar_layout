# == Schema Information
#
# Table name: tables
#
#  id                  :bigint           not null, primary key
#  body                :text
#  column              :integer
#  extended_line_count :integer
#  row                 :integer
#  source              :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  table_style_id      :integer
#  working_article_id  :bigint           not null
#
# Indexes
#
#  index_tables_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#
require 'test_helper'

class TableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
