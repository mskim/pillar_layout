# frozen_string_literal: true

# == Schema Information
#
# Table name: group_images
#
#  id                  :bigint           not null, primary key
#  caption             :string
#  column              :integer
#  direction           :string
#  extended_line_count :integer
#  position            :integer
#  row                 :integer
#  source              :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  working_article_id  :bigint           not null
#
# Indexes
#
#  index_group_images_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

class GroupImage < ApplicationRecord
  belongs_to :working_article
  before_create :setup
  has_many :member_images
  has_many_attached :group_images

  # has_one_attach
  def pdf_path
    working_article.path + "/images/group_image.pdf"
  end

  def image_paths
    if group_images.attached?
      group_images.map do |image|
        ActiveStorage::Blob.service.send(:path_for, image.key)
      end
    end
  end

  def create_member_images
    if group_images.attached?
      group_images.each_with_index do |image, i|
        image_path = ActiveStorage::Blob.service.send(:path_for, image.key)
        MemberImage.create(group_image_id: self.id, member_img: image_path, order: i)
      end
    end
  end

  def layout_hash
    h = {}
    h[:image_path]        = pdf_path
    h[:image_ext]         = "pdf"
    h[:column]            = column
    h[:row]               = row
    h[:position]          = position.to_i
    h[:extra_height_in_lines] = extra_height_in_lines || 0
    h[:is_float]          = true
    h
  end

  def member_images_info
    member_images.map{|member| member.info_hash}
  end

  def member_images_layout
    s = ""
    member_images.each do |member|
      s += member.layout_rb  
    end
    s
  end

  def width
    column*working_article.grid_width
  end

  def height
    h = row*working_article.grid_height
    h += extended_line_count*working_article.body_line_height
  end

  def size_info
    h = {}
    h[:width]   = width
    h[:height]  = height
    h
  end

  def group_image_layout_hash
    h = {}
    h[:image_path]        = pdf_path
    h[:column]            = column
    h[:row]                 = row
    h[:extended_line_count] = extended_line_count if extended_line_count != 0
    h
  end

  def layout_rb
    layout=<<~EOF
    RLayout::NewsArticleBox(#{size_info}) do
      #{member_images_layout}
    end
    EOF
  end

  def generate_pdf
    group_image = eval(layout_rb)
    group_image.save_pdf_in_ruby(pdf_path)
  end

  def save_default
    setup
    self.save
  end

  private

  def setup
    if working_article.column > 3
      self.column = 4 unless column
      self.row    = 1 unless row
    else 
      self.column = working_article.column unless column
      self.row    = 1 unless row
    end
    self.extended_line_count = 0 unless extended_line_count
  end
end
