# == Schema Information
#
# Table name: table_styles
#
#  id             :bigint           not null, primary key
#  category_level :integer
#  column         :integer
#  heading_level  :integer
#  layout         :text
#  name           :string
#  row            :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class TableStyle < ApplicationRecord
  after_create :setup

  def table_style_path
    "#{Rails.root}/public/1/table_style"
  end

  def path
    table_style_path + "/#{column}/"
  end

  def pdf_path
    path + "/#{slug}.pdf"
  end

  def table_style_url
    "/public/1/table_style"
  end

  def url
    table_style_url + "/#{column}"
  end

  def pdf_url
    url + "/#{slug}.pdf"
  end

  def jpg_url
    url + "/#{slug}.jpg"
  end

  def slug
    name.gsub(" ", "_")
  end

  def make_layout

  end

  def generate_pdf
    table_object = eval(make_layout)
    table_object.save_pdf_with_ruby(pdf_path)
  end

  private
  def setup

  end
  
end
