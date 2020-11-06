# == Schema Information
#
# Table name: annotations
#
#  id                 :bigint           not null, primary key
#  version            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint           not null
#
# Indexes
#
#  index_annotations_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#
class Annotation < ApplicationRecord
  before_create :init
  after_create :copy_proof

  belongs_to :working_article
  has_many :annotation_comments
  has_many :annotation_circles
  has_many :annotation_checks

  def path
    working_article.path + "/annotation/version_#{version}"
  end

  def width
    working_article.width
  end

  def height
    working_article.height
  end


  def to_svg
    svg = <<~EOF
      <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{width} #{height}' data-target='draggable.background' >
        <rect fill='white' x='0' y='0' width='#{working_article.width}' height='#{working_article.height}' />
        #{box_svg_with_jpg}
      </svg>
    EOF
  end

  def article_svg_with_jpg
    s = "<image xlink:href='#{working_article.jpg_image_path}' x='0' y='0' width='#{width}' height='#{height}' />\n"
    # s += "<a xlink:href='/annotations/#{id}/de_selecte_all'><rect fill='white' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{0}' y='#{0}' width='#{width}' height='#{height}' /></a>\n"
    s += "<rect fill='white' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{0}' y='#{0}' width='#{width}' height='#{height}' />\n"
  end

  def box_svg_with_jpg
    box_element_svg = article_svg_with_jpg
    box_element_svg += "<g transform='translate(#{0},#{0})' >\n"

    annotation_comments.each do |comment|
      box_element_svg += comment.to_svg
    end
    annotation_circles.each do |circle|
      box_element_svg += circle.to_svg
    end
    annotation_checks.each do |check|
      box_element_svg += check.to_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def add_comment(user_id)
    AnnotationComment.create!(annotation: self, user_id: user_id)
  end

  def add_circle(user_id)
    AnnotationCircle.create!(annotation: self, user_id: user_id)
  end

  def add_check(user_id)
    AnnotationCheck.create!(annotation: self, user_id: user_id)
  end

  private

  def init
    self.version  = working_article.annotations.length + 1
  end

  def copy_proof
    FileUtils.mkdir_p(path) unless File.exist? path
    source = working_article.jpg_path
    target = path + "/proof.jpg"
    FileUtils.cp(source, target)
  end
end
