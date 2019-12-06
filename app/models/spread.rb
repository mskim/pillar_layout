# == Schema Information
#
# Table name: spreads
#
#  id            :bigint           not null, primary key
#  bottom_margin :float
#  color_page    :boolean
#  height        :float
#  left_margin   :float
#  page_gutter   :float
#  right_margin  :float
#  top_margin    :float
#  width         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ad_box_id     :integer
#  issue_id      :bigint
#  left_page_id  :integer
#  right_page_id :integer
#
# Indexes
#
#  index_spreads_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

class Spread < ApplicationRecord
  belongs_to :issue
  before_create :init_atts
  after_create :setup

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
  end

  def publication
    issue.publication
  end

  def left_page
      left_page ||= issue.spread_left_page
  end

  def right_page
      right_page ||= issue.spread_right_page
  end

  def path
    "#{Rails.root}/public/#{publication.id}/issue/#{issue.date.to_s}/spread"
  end

  def relative_path
    "/#{publication.id}/issue/#{issue.date.to_s}/spread"
  end

  def pdf_image_path
    relative_path + "/output.pdf"
  end

  def page_top_position
    top_margin + publication.inner_page_heading_height_in_pt
  end

  def spread_heading_image_layout
    "# spread_heading_image_layout"
  end

  def left_page_image_layout
    "image(image_path: '#{left_page.pdf_path}', x: #{left_margin}, y: #{top_margin},width: #{publication.page_width}, height:#{publication.page_height})"
  end

  def right_page_image_layout
    "image(image_path: '#{right_page.pdf_path}', x: #{left_margin + publication.page_width + right_margin*2}, y: #{top_margin},width: #{publication.page_width}, height:#{publication.page_height})"
  end

  def spread_ad
    ad ||= AdBox.find(ad_box_id).first if ad_box_id
  end

  def ad_image_layout
    #TODO fix height
    if ad_box_id
      "image(image_path:'#{spread_ad.pdf_path}', x: #{left_margin }, y: #{top_margin}, width: #{publication.page_width}, height:#{publication.page_height})"
    else
      "#ad box image layout"
    end
  end

  def spread_layout
    layout=<<~EOF
    RLayout::Container.new(width: #{width}, height:#{height}) do
      #{spread_heading_image_layout}
      #{left_page_image_layout}
      #{right_page_image_layout}
      #{ad_image_layout}
    end
    EOF
  end

  def spread_lqyout_path
    path + "/layout.rb"
  end

  def save_layout
    File.open(spread_lqyout_path, 'w'){|f| f.write spread_layout}
  end

  def generate_pdf
    save_layout
    #TODO set output to spread.pdf, spread.jpg
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  private

  def init_atts
    unless issue
      puts 'No Issue found!!!'
      return nil
    end
    if issue.pages.count == 0
      puts 'No Pages found!!!'
      return nil
    else
      left_page          = issue.spread_left_page
      self.left_page_id  = left_page.id
      self.right_page_id = issue.spread_right_page.id
      self.width         = publication.spread_width
      self.height        = publication.height

      self.left_margin   = publication.left_margin
      self.top_margin    = publication.top_margin
      self.right_margin  = publication.right_margin
      self.bottom_margin = publication.bottom_margin
      self.page_gutter   = publication.left_margin*2 
      self.color_page    = left_page.color_page
    end

  end
end
