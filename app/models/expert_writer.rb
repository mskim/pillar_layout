# == Schema Information
#
# Table name: expert_writers
#
#  id               :bigint           not null, primary key
#  category_code    :string
#  email            :string
#  expert_image     :string
#  expert_jpg_image :string
#  name             :string
#  position         :string
#  work             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

EXPERT_PROFILE_ERB=<<EOF
RLayout::Container.new(width:158.74015748031, height: 162.83914494488) do
  line(x: 0 , y: 1.25, width: 158.74015748031, stroke_width: 2, height:0, stroke_color:'CMYK=0,0,0,100')
  text('<%= title %>', x: 0, y:8, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:'CMYK=0,0,0,100')
  rect(x: 0, y: 70, width:158.74015748031, height: 65,  fill_color:'CMYK=0,0,0,10')
  image(local_image: '<%= name %>.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
  container(x: 70, y: 80, width:150, bottom_margin: 10, fill_color: 'clear') do
    text('<%= position %>', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
    text('<%= display_name %>', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
  end
end
EOF

class ExpertWriter < ApplicationRecord
  # mount_uploader :expert_image, ExpertImageUploader
  # mount_uploader :expert_jpg_image, ExpertJpgImageUploader

  def path
    "#{Rails.root}/public/#{1}/expert"
  end

  def pdf_path
    path + "/#{name}.pdf"
  end

  def pdf_image_path
    "/#{1}/expert/#{name}.pdf"
  end

  def jpg_image_path
    "/#{1}/expert/#{name}.jpg"
  end

  def profile_jpg_path
    filtered_name = name
    filtered_name = name.split("_").first if name.include?("_")
    filtered_name = name.split("=").first if name.include?("=")
    "/#{1}/expert/images/#{filtered_name}.jpg"
  end

  def self.generate_profile_image
    experts = expertWriter.all
    experts.each do |expert|
      expert.generate_pdf
    end
  end

  def layout_path
    path + "/#{name}.rb"
  end

  def csv_path
    "#{Rails.root}/public/#{1}/expert/#{expert.csv}"
  end

  def layout_rb
    erb = ERB.new(EXPERT_PROFILE_ERB)
    layout_rb = erb.result(binding)
  end

  def save_layout
    erb = ERB.new(layout_erb)
    layout_rb = erb.result(binding)
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "_t_#{t.day.to_s.rjust(2,'0')}#{t.hour.to_s.rjust(2,'0')}#{t.min.to_s.rjust(2,'0')}#{t.sec.to_s.rjust(2,'0')}"
  end

  def delete_old_files
    old_pdf_files = Dir.glob("#{path}/#{name}_t_*.pdf")
    old_jpg_files = Dir.glob("#{path}/#{name}-t-*.jpg")
    old_pdf_files += old_jpg_files
    old_pdf_files.each do |old|
      system("rm #{old}")
    end
  end

  def generate_pdf_with_time_stamp
    save_layout
    delete_old_files
    stamp_time
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{@time_stamp}"
  end


  def generate_pdf
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman rjob #{name}.rb -jpg"
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = %w[name  title  work  position  email  cell  expert_image  1   category_code]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

end
