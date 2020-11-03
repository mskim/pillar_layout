module StaticIssue
  extend ActiveSupport::Concern

  def static_path
    path + "/website_#{date.to_s}"
  end

  def static_index_html_path
    static_path + "/index.html"
  end

  def static_images_path
    static_path + "/images"
  end

  def static_zip_path
    static_path + "/website_#{date.to_s}.zip"
  end

  # create build folder
  def build_website
    FileUtils.mkdir_p(static_path) unless File.exist?(static_path)
    copy_images_to_static
    create_static_index_html
    create_static_pages
    system("rm -rf #{static_zip_path}") if File.exist?(static_zip_path)
    zip_static_issue
  end

  def copy_images_to_static
    FileUtils.mkdir_p(static_images_path) unless File.exist?(static_images_path)
    target_folder = static_images_path
    pages.each do |p|
      system "cp #{p.jpg_path} #{p.static_jpg_path}"
    end
  end

  def static_issue_template_path
    "#{Rails.root}/app/views/issues/static_issue.html.erb"
  end

  def pages_links_for_index
    pages.map{|p| p.index_page_link}
  end

  def pages_links
    pages.map{|p| p.page_link}
  end

  def static_issue_conent
    template = File.open(static_issue_template_path, 'r'){|f| f.read}
    @pages_links = pages_links_for_index
    erb = ERB.new(template)
    s = erb.result(binding)
    s
  end

  def create_static_index_html
    content = static_issue_conent
    File.open(static_index_html_path, 'w'){|f| f.write content}
  end

  def create_static_pages
    FileUtils.mkdir_p(static_images_path) unless File.exist?(static_images_path)
    pages.each do |p|
      p.create_static_page
    end
  end

  #   directory_to_zip = "/tmp/input"
  #   output_file = "/tmp/out.zip"
  #   zf = ZipFileGenerator.new(directory_to_zip, output_file)
  #   zf.write()
  def zip_static_issue
    directory_to_zip  = static_path
    output_file       = static_zip_path 
    zf                = ZipFileGenerator.new(directory_to_zip, output_file)
    zf.write()
  end

  ##### old

  def front_page_layout_erb(options={})
    layout =<<~EOF

    EOF
  end

  def section_layout_erb(section_name, options={})
    layout =<<~EOF

    EOF
  end

  def article_layout_erb(options={})
    layout =<<~EOF

    EOF
  end

  def save_html
    pages.each do |page|
      page.save_html
    end
  end

end



require 'zip'

# This is a simple example which uses rubyzip to
# recursively generate a zip file from the contents of
# a specified directory. The directory itself is not
# included in the archive, rather just its contents.
#
# Usage:
#   directory_to_zip = "/tmp/input"
#   output_file = "/tmp/out.zip"
#   zf = ZipFileGenerator.new(directory_to_zip, output_file)
#   zf.write()

# https://github.com/rubyzip/rubyzip
class ZipFileGenerator
  # Initialize with the directory to zip and the location of the output archive.
  def initialize(input_dir, output_file)
    @input_dir = input_dir
    @output_file = output_file
  end

  def write
    entries = Dir.entries(@input_dir) - %w[. ..]
    ::Zip::File.open(@output_file, ::Zip::File::CREATE) do |zipfile|
      write_entries entries, '', zipfile
    end
  end

  private

  # A helper method to make the recursion work.
  def write_entries(entries, path, zipfile)
    entries.each do |e|
      zipfile_path = path == '' ? e : File.join(path, e)
      disk_file_path = File.join(@input_dir, zipfile_path)
      puts "Deflating #{disk_file_path}"

      if File.directory? disk_file_path
        recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
      else
        put_into_archive(disk_file_path, zipfile, zipfile_path)
      end
    end
  end

  def recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
    zipfile.mkdir zipfile_path
    subdir = Dir.entries(disk_file_path) - %w[. ..]
    write_entries subdir, zipfile_path, zipfile
  end

  def put_into_archive(disk_file_path, zipfile, zipfile_path)
    zipfile.get_output_stream(zipfile_path) do |f|
      f.write(File.open(disk_file_path, 'rb').read)
    end
  end
end
