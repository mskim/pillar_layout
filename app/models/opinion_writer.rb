# == Schema Information
#
# Table name: opinion_writers
#
#  id                :bigint           not null, primary key
#  category_code     :integer
#  cell              :string
#  email             :string
#  name              :string
#  opinion_image     :string
#  opinion_jpg_image :string
#  position          :string
#  title             :string
#  work              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  publication_id    :bigint
#
# Indexes
#
#  index_opinion_writers_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class OpinionWriter < ApplicationRecord
  belongs_to :publication
  mount_uploader :opinion_image, OpinionImageUploader
  mount_uploader :opinion_jpg_image, OpinionJpgImageUploader

  def path
    "#{Rails.root}/public/#{publication.id}/opinion"
  end

  def pdf_path
    path + "/#{name}.pdf"
  end

  def pdf_image_path
    "/#{publication.id}/opinion/#{name}.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/opinion/#{name}.jpg"
  end

  def csv_path
    "#{Rails.root}/public/#{publication.id}/opinion/#{opinion.csv}"
  end

  def layout_rb
    erb = ERB.new(layout_erb)
    erb.result(binding)
  end

  def save_layout
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

  # def generate_pdf_with_time_stamp
  #   save_layout
  #   delete_old_files
  #   stamp_time
  #   system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{@time_stamp}"
  # end


  def generate_pdf
    if RUBY_ENGINE !='rubymotion'
      save_pdf_in_ruby
    else
      save_layout
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman rjob #{name}.rb -jpg"
    end
  end

  def save_pdf_in_ruby
    convert_eps_to_pdf unless File.exist?(picture_pdf_path)
    output_path = path + "/#{name}.pdf"
    script = layout_rb
    RLayout::RJob.new(script: layout_rb, output_path: output_path)
    convert_pdf2jpg(output_path)
  end

  def convert_pdf2jpg(output_path)
    pdf_folder    = File.dirname(output_path)
    pdf_base_name = File.basename(output_path)
    jpg_base_name = pdf_base_name.gsub(/.pdf$/, ".jpg")
    commend  = "cd #{pdf_folder} && vips copy #{pdf_base_name}[n=-1] #{jpg_base_name}"
    system(commend)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = %w[name  title  work  position  email  cell  opinion_image  publication_id   category_code]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

  def profile_jpg_path
    "/#{publication.id}/opinion/images/#{picture_name}.jpg"
  end

  def picture_name
    picture_name = name
    picture_name = name.split("_").first if name.include?("_")
    picture_name = name.split("=").first if name.include?("=")
    picture_name
  end

  def picture_folder
    path + "/images"
  end

  def picture_eps_path
    picture_folder + "/#{picture_name}.eps"
  end

  def picture_pdf_path
    picture_folder + "/#{picture_name}.pdf"
  end

  def convert_eps_to_pdf
    unless File.exist?(picture_eps_path)
      puts "No EPS file found!!!"
      return
    end
    system("cd #{picture_folder} && convert -density 300  #{picture_name}.eps #{picture_name}.pdf")
  end

  def layout_path
    path + "/#{name}.rb"
  end

  def layout_erb

    layout=<<~EOF
    RLayout::Container.new(width:158.74015748031, height: 162.83914494488) do
      line(x: 0 , y: 1.35, width: 158.74015748031, stroke_width: 3.5, height:0, stroke_color:'CMYK=0,0,0,100')
      text('<%= title %>', x: 0, y:8, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:'CMYK=0,0,0,100')
      rect(x: 0, y: 70, width:158.74015748031, height: 65,  fill_color:'CMYK=0,0,0,10')
      image(image_path: '<%= picture_pdf_path %>', y: 60, width: 60, height: 75, fill_color: 'clear')
      container(x: 70, y: 80, width:150, bottom_margin: 10, fill_color: 'clear') do
        <% if name && name.include?('_') %>
          text('<%= work %>', y:30, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100' )
          text('<%= position %>', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
        <% elsif name && work && work != '' && position && position != '' %>
          <% if name.include?('=') %>
            text('<%= name.split('=').first %>', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% elsif name.include?('-') %>
            text('<%= name.split('-').first %>', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% else  %>
            text('<%= name.gsub('+', ' ') %>', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% end  %>
          text('<%= work %>', y:30, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          text('<%= position %>', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
        <% elsif position == '' || position == nil %>
          <% if name.include?('=') %>
            text('<%= name.split('=').first %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% elsif name.include?('-') %>
            text('<%= name.split('-').first %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% else  %>
            text('<%= name.gsub('+', ' ') %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% end  %>
          text('<%= work %>', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
        <% elsif work == '' || work == nil %>
          <% if name.include?('=') %>
            text('<%= name.split('=').first %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% elsif name.include?('-') %>
            text('<%= name.split('-').first %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% else  %>
            text('<%= name.gsub('+', ' ') %>', y:28, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
          <% end  %>
          text('<%= position %>', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
        <% end %>
      end
    end
    EOF

  end
end
