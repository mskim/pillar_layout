# == Schema Information
#
# Table name: page_heading_kinds
#
#  id              :bigint           not null, primary key
#  bg_image        :string
#  height_in_lines :integer
#  layout_erb      :text
#  page_type       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  publication_id  :bigint
#
# Indexes
#
#  index_page_heading_kinds_on_publication_id  (publication_id)
#
class PageHeadingKind < ApplicationRecord
  belongs_to :publication

  def page_heading_kind_csv_path
    "#{Rails.root}/public/1/page_heading_kind.csv"
  end

  def self.parse_csv
    csv_text = File.read(page_heading_kind_csv_path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      h = row.to_hash
      h = Hash[h.map{ |key, value| [key.to_sym, value] }]
      h[:publication_id] = 1
      PageHeadingKind.where(h).first_or_create
    end
  end

  def self.save_csv
    page_headings_csv = PageHeadingKind.all.to_csv
    File.open(page_heading_kind_csv_path, 'w'){|f| f.write page_headings_csv}
  end

  
end
