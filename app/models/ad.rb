# == Schema Information
#
# Table name: ads
#
#  id             :integer          not null, primary key
#  name           :string
#  column         :integer
#  row            :integer
#  page_columns   :integer
#  publication_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Ad < ApplicationRecord
  belongs_to :publication
  belongs_to :issue, optional: true
  after_create :setup
  validates :column, presence: true
  validates :row, presence: true
  validates :page_columns, presence: true
  validates :publication_id, presence: true

  def path
    "#{Rails.root}/public/#{publication_id}/ad/#{page_columns}/#{name}"
  end

  def self.side_ads
    %w[7단15 7단27 8단27 9단21]
  end

  def images_path
    path + "/images"
  end

  def self.seed_ad
    ad_csv_path = "#{Rails.root}/public/1/ad/ads.csv"
    csv_text = File.read(ad_csv_path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # puts "row.to_hash:#{row.to_hash}"
      Ad.where(row.to_hash).first_or_create
    end
  end

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
    system "mkdir -p #{images_path}" unless File.directory?(images_path)
  end

  def generate_pdf
    # puts "generate_pdf of Ad :#{id}"
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def ad_width
    publication.width_of_grid_frame(page_columns, [0,0,column,row])
  end

  def ad_height
    publication.height_of_grid_frame(page_columns, [0,0,column,row])
  end

  def grid_width
    publication.grid_width(page_columns)
  end

  def grid_height
    publication.grid_height
  end

  def ad_top_margin
    publication.body_line_height
  end

  def page_heading_margin_in_lines
    publication.inner_page_heading_height
  end

  def layout_rb
    # puts "saving ad layout_rb"
    # puts "path:#{path}"
    content=<<~EOF
    RLayout::NewsAdBox.new(is_ad_box: true, column: #{column}, row: #{row}, page_heading_margin_in_lines: #{page_heading_margin_in_lines}) do
      image(image_path: 'some_path', layout_expand: [:width, :height])
      relayout!
    end
    EOF
  end

  def layout_path
    path + "/layout.rb"
  end

  def sample_ad_path
    "#{Rails.root}/public/#{publication_id}/ad/sample/#{name}"
  end

  def copy_sample_ad
    # copy random asmple ad
    # name
    ad = Dir.glob("#{sample_ad_path}/*{.jpg,.pdf}").sample
    # puts "sample_ad_path:#{sample_ad_path}"
    # puts "ad:#{ad}"
    # puts "cp #{ad} #{ad_folder}/images/1.jpg"
    if ad
      system "cp #{ad} #{path}/images/1.jpg"
    end
  end

  def save_layout
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        # get rif of id, created_at, updated_at
        filtered = column_names.dup
        filtered.shift
        filtered.pop
        filtered.pop
        csv << filtered
        all.each do |item|
          csv << item.attributes.values_at(*filtered)
        end
      end
  end

  def svg_unit_width
    grid_width/3
  end

  def svg_unit_height
    grid_height/3
  end

  def x_grid
    return 0 if name.include?("_짝")
    page_columns - column
  end

  def y_grid
    publication.row - row
  end

  def svg_box
    # TODO put story number on top
    # make width for 6 column same as 7 column
    string = ""
    string += "<rect fill='white' stroke='#000000' stroke-width='0' x='#{0}' y='#{0}' width='#{page_columns*svg_unit_width}' height='#{15*svg_unit_height}'/>\n"
    string += "<rect fill='red' stroke='#000000' stroke-width='0' x='#{x_grid*svg_unit_width}' y='#{y_grid*svg_unit_height}' width='#{column*svg_unit_width}' height='#{row*svg_unit_height}'/>\n"
    string
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0' y='0' stroke='black' stroke-width='4' width='#{page_columns*svg_unit_width}' height='#{15*svg_unit_height}'>
      #{svg_box}
    </svg>
    EOF
  end


  def save_current_ads
    csv_path = "#{Rails.root}/public/1/ad/ads.csv"
    File.open(csv_path, 'w'){|f| f.write Ad.to_csv.to_s}
  end

end
