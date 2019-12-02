# == Schema Information
#
# Table name: opinion_writers
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  title             :string
#  work              :string
#  position          :string
#  email             :string
#  cell              :string
#  opinion_image     :string
#  publication_id    :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_code     :integer
#  opinion_jpg_image :string
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

  def profile_jpg_path
    filtered_name = name
    filtered_name = name.split("_").first if name.include?("_")
    filtered_name = name.split("=").first if name.include?("=")
    "/#{publication.id}/opinion/images/#{filtered_name}.jpg"
  end

  def layout_path
    path + "/#{name}.rb"
  end

  def csv_path
    "#{Rails.root}/public/#{publication.id}/opinion/#{opinion.csv}"
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
      header = %w[name  title  work  position  email  cell  opinion_image  publication_id   category_code]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end


  def layout_erb

    layout=<<~EOF
    RLayout::Container.new(width:158.74015748031, height: 162.83914494488) do
      line(x: 0 , y: 1.35, width: 158.74015748031, stroke_width: 3.5, height:0, stroke_color:'CMYK=0,0,0,100')
      text('<%= title %>', x: 0, y:8, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:'CMYK=0,0,0,100')
      rect(x: 0, y: 70, width:158.74015748031, height: 65,  fill_color:'CMYK=0,0,0,10')
      <% if name.include?('_')  %>
        <% name_without_rest = name.split('_').first %>
        image(local_image: '<%= name_without_rest %>.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
      <% elsif name.include?('=') %>
        <% name_without_rest = name.split('=').first %>
        image(local_image: '<%= name_without_rest %>.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
      <% else %>
        image(local_image: '<%= name %>.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
      <% end %>
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
