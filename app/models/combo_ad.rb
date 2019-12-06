# == Schema Information
#
# Table name: combo_ads
#
#  id         :bigint           not null, primary key
#  base_ad    :string
#  column     :integer
#  layout     :text
#  profile    :string
#  row        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ComboAd < ApplicationRecord
  before_create :parse_profile
  after_create :setup

  def path
    "#{Rails.root}/public/#{1}/combo_ad/#{profile}"
  end

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
  end

  def svg_unit_width
    400/column
  end

  def svg_unit_height
    30
  end

  def eval_layout
    eval(layout)
  end

  def svg_box
    # TODO put story number on top
    # make width for 6 column same as 7 column
    string = ""
    eval_layout.each do |box|
      string += "<rect fill='white' stroke='#000000' stroke-width='4' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
    end
    string
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0' y='0' stroke='black' stroke-width='4' width='#{column*svg_unit_width}' height='#{row*svg_unit_height}'>
      #{svg_box}
    </svg>
    EOF
  end

  def box_count
    eval_layout.length
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      # get rif of id, created_at, updated_at
      # header = %w[page_number section_name profile column row order ad_type is_front_page story_count color_page draw_divider publication_id layout]
      header = %w[base_ad  column  row  layout]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

  def make_unit_ad
    layout = []
    row.times do |j|
      column.times do |i|
        layout << [i,j,1,1]
      end
    end
    self.layout = layout.to_s
    self.save
  end

  def self.make_unit_ad
    all.each do |combo_ad|
      next combo_ad.box_count > 0
      combo_ad.make_unit_ad
    end
  end

  private
  def parse_profile
    layout_array  = eval(layout)
    ad            = Ad.find_by(name: base_ad)
    self.layout   = layout_array.sort_by {|rect| [rect[0], rect[1]]}.to_s
    self.profile  = make_profile
    true
  end

  def make_profile
    profile = "#{base_ad}_"
    profile += "#{column}x#{row}_"
    profile += eval(layout).length.to_s
    profile
  end
end
