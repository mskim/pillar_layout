# == Schema Information
#
# Table name: stroke_styles
#
#  id             :bigint           not null, primary key
#  klass          :string
#  name           :string
#  stroke         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#
# Indexes
#
#  index_stroke_styles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

class StrokeStyle < ApplicationRecord
  belongs_to :publication
  validates :klass, presence: true
  validates :name, presence: true

  def path
    "#{Rails.root}/public/#{publication.id}/stroke_style/#{klass}"
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

  def self.current_style_list
    styles_list = []
    h = {}
    filtered = column_names.dup
    filtered.shift  # delete id
    # filtered.shift  # delete name
    filtered.pop    # delete created_at
    filtered.pop    # delete updated_at
    all.each do |item|
      styles_list << Hash[filtered.zip item.attributes.values_at(*filtered)]
    end
    styles_list
  end

  def self.current_styles_with_klass_key(options = {})
    # get rif of id, created_at, updated_at
    styles_hash = {}
    h = {}
    filtered = column_names.dup
    filtered.shift  # delete id
    filtered.delete('klass')  # delete klass
    filtered.pop    # delete created_at
    filtered.pop    # delete updated_at
    filtered.pop    # delete publication_id
    all.each do |item|
      styles_hash[item.attributes['klass']] = Hash[filtered.zip item.attributes.values_at(*filtered)]
    end
    styles_hash
  end

  def save_current_styles_with_klass_key
    # folder = "/Users/Shared/SoftwareLab/newspaper_stroke_style"
    # path = folder + "/#{publication.name}.yml"
    folder = "/Users/Shared/SoftwareLab/newsman/#{publication.name}"
    system("mkdir -p #{folder}") unless File.directory?(folder)
    path = folder + "/stroke_style.yml"
    styles_hash = StrokeStyle.current_styles_with_klass_key
    File.open(path, 'w'){|f| f.write styles_hash.to_yaml}
    path = folder + "/#{publication.name}.rb"
    File.open(path, 'w'){|f| f.write styles_hash.to_s}
  end

  def path
    "#{Rails.root}/public/#{publication.id}/stroke_style/#{english}"
  end

  def images_path
    path + "/images"
  end

  def layout_path
    path + "/layout.rb"
  end

  def story_path
    path + "/story.md"
  end

  def pdf_path
    path + "/output.pdf"
  end

  def jpg_path
    path + "/output.jpg"
  end

  def pdf_image_path
    "/#{publication.id}/stroke_style/#{klass}/output.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/stroke_style/#{klass}/output.jpg"
  end

  def setup
    system("mkdir -p #{path}") unless File.directory?(path)
  end


end
