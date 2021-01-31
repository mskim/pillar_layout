# == Schema Information
#
# Table name: profiles
#
#  id                :bigint           not null, primary key
#  category_code     :integer
#  email             :string
#  name              :string
#  position          :string
#  profile_image     :string
#  profile_jpg_image :string
#  title             :string
#  work              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  publication_id    :bigint
#
# Indexes
#
#  index_profiles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class Profile < ApplicationRecord
  belongs_to :publication
  mount_uploader :profile_image, ProfileImageUploader
  mount_uploader :profile_jpg_image, ProfileJpgImageUploader
  include Pdf2jpg

  def path
    "#{Rails.root}/public/#{publication.id}/profile"
  end

  def pdf_path
    path + "/#{name}.pdf"
  end

  def pdf_image_path
    "/#{publication.id}/profile/#{name}.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/profile/#{name}.jpg"
  end

  def profile_jpg_path
    "/#{publication.id}/profile/images/#{name}.jpg"
  end

  def layout_path
    path + "/#{name}.rb"
  end

  def csv_path
    "#{Rails.root}/public/#{publication.id}/profile/#{profile.csv}"
  end

  def convert_eps_to_pdf
    system("cd ##{person_image_folder}convert -density 300  #{name}.eps 홍면기.pdf")
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

  def person_image_folder
    folder_path = path + "/images"
  end

  def person_image_path
    person_image_folder + "/#{name}"
  end

  def layout_erb
    layout =<<~EOF
    RLayout::Container.new(width:158.74015748031,  height: 75) do
      rect(x: 0, y: 10, width:158.74015748031, height: 65, fill_color:"CMYK=0,0,0,10")
      image(image_path: '<%= picture_pdf_path %>', x: 98.74015748031, y: 0, width: 60, height: 75, fill_color: 'clear')
      container(x: 0, y: 20, width:100, bottom_margin: 10, fill_color: 'clear') do
        <% if name && work && work != "" && position && position != "" %>
          <% if name.include?('-') %>
            text('<%= name.split("-").first %>', text_alignment: 'right', from_right: 10, y:17, font: 'KoPubDotumPB', font_size: 9, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% else  %>
            text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:17, font: 'KoPubDotumPB', font_size: 9,text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% end  %>
            text('<%= work %>', text_alignment: 'right', from_right: 10, y:30, font: 'KoPubDotumPL', font_size: 8, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
            text('<%= position %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
        <% elsif position == "" || position == nil %>
          <% if name.include?('-') %>
            text('<%= name.split("-").first %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% else  %>
            text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9,text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% end  %>
            text('<%= work %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear')
        <% elsif work == "" || work == nil %>
          <% if name.include?('-') %>
            text('<%= name.split("-").first %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% else  %>
            text('<%= name.gsub("+", " ") %>', text_alignment: 'right', from_right: 10, y:28, font: 'KoPubDotumPB', font_size: 9,text_color:"CMYK=0,0,0,100", fill_color: 'clear')
          <% end  %>
            text('<%= position %>', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, text_color:"CMYK=0,0,0,100", fill_color: 'clear')
        <% end %>
      end
    end
    EOF
  end

  def layout_rb
    erb = ERB.new(layout_erb)
    erb.result(binding)
  end

  def save_layout
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def generate_pdf
    save_pdf_in_ruby
  end

  def save_pdf_in_ruby
    convert_eps_to_pdf unless File.exist?(picture_pdf_path)
    output_path = path + "/#{name}.pdf"
    script = layout_rb
    RLayout::RJob.new(script: layout_rb, output_path: output_path)
    convert_pdf2jpg(output_path)
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
end
