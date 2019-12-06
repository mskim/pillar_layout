# == Schema Information
#
# Table name: announcements
#
#  id             :bigint           not null, primary key
#  color          :string
#  column         :integer
#  kind           :string
#  lines          :integer
#  name           :string
#  page           :integer
#  page_column    :integer
#  script         :text
#  subtitle       :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#
# Indexes
#
#  index_announcements_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class Announcement < ApplicationRecord
  belongs_to :publication
  validates_presence_of :name
  validates_uniqueness_of :name
  after_create :setup

  def path
    "#{Rails.root}/public/#{publication.id}/announcement"
  end

  def pdf_path
    path + "/#{name}.pdf"
  end

  def pdf_image_path
    "/#{publication.id}/announcement/#{name}.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/announcement/#{name}.jpg"
  end

  def save_layout
    erb = ERB.new(script)
    layout_rb = erb.result(binding)
    layout_rb
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def generate_pdf
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman rjob #{name}.rb -jpg"
  end
  
  def column_width
    
  end

  def body_line_height
    publication.body_line_height
  end

  def width
    column_width*column
  end

  def height
    lines*body_line_height
  end

  def setup
    FileUtils.mkdir_p path unless File.exist?(path)
layout_rb=<<EOF
RLayout::Container.new(width: #{width} height:#{height}) do
    text(#{title})
end
EOF

    if column == 1

    elsif column == 2

    end

    self.script = layout_rb
    self.save
  end

end
