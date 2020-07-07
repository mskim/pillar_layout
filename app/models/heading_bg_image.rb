# == Schema Information
#
# Table name: heading_bg_images
#
#  id               :bigint           not null, primary key
#  heading_bg_image :string
#  name             :string
#  paper_size       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class HeadingBgImage < ApplicationRecord
  # belongs_to :page_heading
  # belongs_to :publication
  mount_uploader :heading_bg_image, HeadingBgImageUploader

  # def publication
  #   page_heading.publication
  # end

  def image_path
    "#{Rails.root}/public" + heading_bg_image.url if heading_bg_image
  end

  def slug
    name.gsub(" ", "_")
  end

  def set_to_current_publication
    current_issue = Publication.first.issues.last
    current_issue.change_heading_bg_image(self)
  end

  # def update_change
  #   page_heading.generate_pdf
  #   page_heading.update_page_pdf
  # end
end
