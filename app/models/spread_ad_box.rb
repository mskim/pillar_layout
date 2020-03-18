# == Schema Information
#
# Table name: spread_ad_boxes
#
#  id         :bigint           not null, primary key
#  ad_type    :string
#  advertiser :string
#  height     :float
#  row        :integer
#  width      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spread_id  :bigint           not null
#
# Indexes
#
#  index_spread_ad_boxes_on_spread_id  (spread_id)
#
# Foreign Keys
#
#  fk_rails_...  (spread_id => spreads.id)
#

class SpreadAdBox < ApplicationRecord
  belongs_to :spread
  before_create :init_spread_ad_box

  def path
    spread.path + "/ad"
  end

  def layout_rb
    ad_image_hash = {}
    ad_image_hash[:image_path]                     = image_path
    ad_image_hash[:fit_type]                       = 4
    ad_image_hash[:layout_expand]                  = [:width, :height]
    ad_image_hash[:page_heading_margin_in_lines]   = page_heading_margin_in_lines
    content=<<~EOF
    RLayout::NewsAdBox.new(is_ad_box: true, width: #{width}, heigth: #{height}) do
      image(#{ad_image_hash})
    end
    EOF
  end

  def layout_path
    path + "/layout.rb"
  end

  def save_layout
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2,'0')}#{t.hour.to_s.rjust(2,'0')}#{t.min.to_s.rjust(2,'0')}#{t.sec.to_s.rjust(2,'0')}"
  end

  private

  def init_spread_ad_box
    self.width  = spread.spread_ad_width
    self.height = spread.spread_ad_height(row)
  end
end
