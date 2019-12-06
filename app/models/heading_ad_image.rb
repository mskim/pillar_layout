# == Schema Information
#
# Table name: heading_ad_images
#
#  id               :bigint           not null, primary key
#  advertiser       :string
#  date             :date
#  heading_ad_image :string
#  height           :float
#  height_in_unit   :float
#  width            :float
#  width_in_unit    :float
#  x                :float
#  x_in_unit        :float
#  y                :float
#  y_in_unit        :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  page_heading_id  :bigint
#
# Indexes
#
#  index_heading_ad_images_on_page_heading_id  (page_heading_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_heading_id => page_headings.id)
#

class HeadingAdImage < ApplicationRecord
  belongs_to :page_heading, optional: true
  mount_uploader :heading_ad_image, HeadingAdImageUploader

  def publication
    page_heading.publication
  end

  def issue
    page_heading.issue
  end

  def image_path
    heading_ad_image.path if heading_ad_image
  end

  def update_page_heading
    puts __method__
    page_heading_path  = Issue.last.pages.first.page_heading.path
    system "cd #{page_heading_path} && /Applications/newsman.app/Contents/MacOS/newsman article ."

    first_page = Issue.last.pages.first
    first_page.generate_pdf_with_time_stamp

    # page_heading.generate_pdf
    # page_heading.update_page_pdf
  end

  def target_folder
    new_page_heading  = Issue.last.pages.first.page_heading.path + '/images'
  end

  def copy_image
    return unless heading_ad_image
    source = heading_ad_image.url
    system("cp #{source} #{target_folder}/") unless target_folder == source
  end

  # set old ad for today by copying it to today's heading folder
  def place_ad_for_today
    copy_image
    update_page_heading
  end

  def new_file_name
    ext
  end

  def date
    created_at.to_date
    # if page_heading
    #   page_heading.issue.date.to_s
    # else
    #   Date.today.to_s
    # end
  end

  private

  def init_atts
    self.page_heading = Issue.last.pages.first.page_heading if Issue.last
  end
end
