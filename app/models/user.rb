# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  cell                   :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  group                  :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("reporter")
#  sign_in_count          :integer          default(0), not null
#  title                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

REPORTER_PROFILE_ERB=<<EOF
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


class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:reporter, :team_leader, :marketing, :chief_editor, :designer, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stories
  has_many :reporter_images
  has_many :reporter_graphics
  has_many :annotation_comments
  # has_many :graphic_requests

  has_one_attached :avatar

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.generate_profile_image
    reporters = User.where(role:'reporter').all
    reporters += User.where(role:'team_leader').all
    reporters.each do |reporter|
      reporter.generate_pdf
    end
  end

  def path
    "#{Rails.root}/public/#{publication.id}/profile_image/reporter"
  end

  def pdf_path
    path + "/#{name}.pdf"
  end

  def pdf_image_path
    "/#{publication.id}/profile_image/reporter/#{name}.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/profile_image/reporter/#{name}.jpg"
  end

  def profile_jpg_path
    filtered_name = name
    filtered_name = name.split("_").first if name.include?("_")
    filtered_name = name.split("=").first if name.include?("=")
    "/#{publication.id}/profile_image/reporter/images/#{filtered_name}.jpg"
  end

  def layout_path
    path + "/#{name}.rb"
  end

  def csv_path
    "#{Rails.root}/public/#{publication.id}/profile_image/reporter/#{profile_image/reporter.csv}"
  end

  def layout_rb
    erb = ERB.new(REPORTER_PROFILE_ERB)
    layout_rb = erb.result(binding)
  end

  def save_layout
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def generate_pdf
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman rjob #{name}.rb -jpg"
  end

  def display_name
    if name.include("-")
      name.split("-").first
    else
      name
    end
  end
end
