# == Schema Information
#
# Table name: article_kinds
#
#  id                     :bigint           not null, primary key
#  bottoms_space_in_lines :integer
#  input_fields           :text
#  layout_erb             :text
#  line_draw_sides        :text
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  publication_id         :bigint           not null
#
# Indexes
#
#  index_article_kinds_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#
class ArticleKind < ApplicationRecord
  belongs_to :publication


  def article_kind_csv_path
    "#{Rails.root}/public/1/article_kind.csv"
  end

  def self.parse_csv
    csv_text = File.read(article_kind_csv_path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      h = row.to_hash
      h = Hash[h.map{ |key, value| [key.to_sym, value] }]
      h[:publication_id] = 1
      ArticleKind.where(h).first_or_create
    end
  end

  def self.save_csv
    article_kind_csv = ArticleKind.all.to_csv
    File.open(article_kind_csv_path, 'w'){|f| f.write article_kind_csv}
  end
end
