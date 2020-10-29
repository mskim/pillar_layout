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
class Table < ApplicationRecord
  belongs_to :working_article

  def layout_hash
    h                       = {}
    h[:column]              = column
    h[:row]                 = row
    h[:extended_line_count] = extended_line_count
    h[:layout]              = "layout" #get this from stable_style
    h
  end

  def path

  end

  def pdf_path

  end

  def url

  end
  
  def pdf_url

  end

  def jpg_url

  end

  def generate_pdf

  end
end
