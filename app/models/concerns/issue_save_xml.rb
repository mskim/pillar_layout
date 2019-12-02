module IssueSaveXml
  extend ActiveSupport::Concern
  
  def xml_path # 데스크탑용 뉴스 XML 
    path + '/newsml'
  end

  def newsml_path
    "#{Rails.root}/public/1/newsml"
  end

  def newsml_issue_path
    "#{Rails.root}/public/1/#{id}/newsml"
  end

  def xml_zip_path # 데스크탑용 뉴스 XML
    year          = date.year
    month         = date.month.to_s.rjust(2, '0')
    day           = date.day.to_s.rjust(2, '0')
    issue_date    = "#{year}#{month}#{day}"
    xml_path + "/#{issue_date}_story_xml.zip"
  end

  def preview_xml_path # 데스크탑용 지면보기 XML 
    path + '/page_preview'
  end

  def preview_xml_zip_path # 데스크탑용 지면보기 XML 
    year          = date.year
    month         = date.month.to_s.rjust(2, '0')
    day           = date.day.to_s.rjust(2, '0')
    issue_date    = "#{year}#{month}#{day}"
    preview_xml_path + "/#{issue_date}_page_preview.zip"
  end

  def mobile_preview_xml_path # 모바일용 지면보기 XML 
    path + '/mobile_page_preview'
  end

  # def mobile_preview_xml_zip_path # 모바일용 지면보기 XML
  #   year = date.year
  #   month         = date.month.to_s.rjust(2, '0')
  #   day           = date.day.to_s.rjust(2, '0')
  #   issue_date    = "#{year}#{month}#{day}"
  #   mobile_preview_xml_path + "/#{issue_date}_mobile_preview_xml.zip"
  # end
  
  def make_preview_xml_zip # 데스크탑용 지면보기 XML 
    # Path where your pdfs are situated (‘my_pdf’ is folder with pdfs)
    folder = preview_xml_path
    input_filenames = Dir.glob("#{preview_xml_path}/*.{xml,jpg,pdf}")
    zipfile_name = preview_xml_zip_path
    system("rm #{preview_xml_zip_path}") if File.exist?(preview_xml_zip_path)
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        base_name = File.basename(filename)
        # Two arguments:
        # – The name of the file as it will appear in the archive
        # – The original file, including the path to find it
        zipfile.add(base_name, File.join(folder, base_name))
      end
      # zipfile.get_output_stream(“success”) { |os| os.write “All done successfully” }
    end
    # send_file(File.join("#{Rails.root}/public/", ‘myfirstzipfile.zip’), :type => ‘application/zip’, :filename => "#{xml_zip_name}")
    # Remove content from ‘my_pdfs’ folder if you want
    # FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/my_pdfs/*"))
  end

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

def make_story_xml_zip # 데스크탑용 뉴스 XML
  # Path where your pdfs are situated (‘my_pdf’ is folder with pdfs)
  folder = xml_path
  # input_filenames = Dir.glob("#{xml_path}/*.xml")
  input_filenames = Dir.glob("#{xml_path}/*.{xml,jpg}")
  zipfile_name = xml_zip_path
  system("rm #{xml_zip_path}") if File.exist?(xml_zip_path)
  Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
    input_filenames.each do |filename|
      base_name = File.basename(filename)
      # Two arguments:
      # – The name of the file as it will appear in the archive
      # – The original file, including the path to find it
      zipfile.add(base_name, File.join(folder, base_name))
    end
    # zipfile.get_output_stream(“success”) { |os| os.write “All done successfully” }
  end
  # send_file(File.join("#{Rails.root}/public/", ‘myfirstzipfile.zip’), :type => ‘application/zip’, :filename => "#{xml_zip_name}")
  # Remove content from ‘my_pdfs’ folder if you want
  # FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/my_pdfs/*"))
end

# def make_mobile_preview_xml_zip
# folder = mobile_preview_xml_path
# input_filenames = Dir.glob("#{mobile_preview_xml_path}/**.*")
# zipfile_name = mobile_preview_xml_zip_path
# system("rm #{mobile_preview_xml_zip_path}") if File.exist?(mobile_preview_xml_zip_path)
# Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
#   input_filenames.each do |filename|
#     base_name = File.basename(filename)
#     zipfile.add(base_name,  File.join(folder, base_name))
#   end
# end

# Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
#   Dir[File.join(folder, '*')].each do |file|
#     zipfile.add(file.sub(folder, ''), file)
#   end
# end
# end

def full_page_ad 
  pages.select{|p| p.section_name == "전면광고"}
end

def save_story_xml # 데스크탑용 기사 XML 
  pages[0..0].each(&:save_story_xml)
  full_page_ad.each(&:save_story_xml)
  pages[9..9].each(&:save_story_xml)
  pages[21..22].each(&:save_story_xml)
  # make_story_xml_zip
end

def save_preview_xml # 데스크탑용 지면보기 XML
  pages[0..0].each(&:save_preview_xml)
  full_page_ad.each(&:save_preview_xml)
  pages[9..9].each(&:save_preview_xml)
  pages[21..22].each(&:save_preview_xml)
  # make_preview_xml_zip
end

def mobile_page_preview_path # 모바일용 지면보기 XML
  "#{Rails.root}/public/1/issue/#{date}/mobile_page_preview"
end

def partial_xml_path # 모바일용 지면보기 XML 콘테이너/업데이트정보 뉴스고 제작분 저장
  "#{Rails.root}/public/1/issue/#{date}/partial_xml"
end

def save_mobile_preview_xml # 모바일용 지면보기 XML
  # full page ad
  s = ''
  u = ''
  # page 1 only for now!!
  pages[0..0].each do |page|
    s += page.all_container
    u += page.updateinfo
    page.save_mobile_preview_xml
    # all_container_xml_page = page.container_xml_page
  end
  pages[9..9].each do |page|
    s += page.all_container
    u += page.updateinfo
    page.save_mobile_preview_xml
    # all_container_xml_page = page.container_xml_page
  end
  full_page_ad.each do |page|
    s += page.all_container
    u += page.updateinfo
    page.save_mobile_preview_xml
    # all_container_xml_page = page.container_xml_page
  end
  # page 22 and 23 only for now!!
  pages[21..22].each do |page|
    s += page.all_container
    u += page.updateinfo
    page.save_mobile_preview_xml
    # all_container_xml_page = page.container_xml_page
  end
  system("mkdir -p #{partial_xml_path}") unless File.exist?(partial_xml_path)
  File.open(partial_xml_path + '/partial_Container.xml', 'w') { |f| f.write s }
  File.open(partial_xml_path + '/partial_updateinfo.xml', 'w') { |f| f.write u }

  # merge_container_xml
  # make_mobile_preview_xml_zip
  # directory_to_zip = mobile_preview_xml_path
  # output_file = mobile_preview_xml_zip_path
  # zf = ZipFileGenerator.new(directory_to_zip, output_file)
  # zf.write()
end

def copy_to_xml_ftp # 데스크탑용 뉴스/지면보기 XML 전송
  # save_story_xml
  # save_preview_xml
  xml_send
  true
end

# def xml_send_code
#   jeho = issue.number
#   yymd = issue.date.strftime("%y%m%d")
#    "#{jeho}-#{yymd}#{pg}.pdf"
# end

def xml_send # 데스크탑용 뉴스/지면보기 XML 전송
  year          = date.year
  month         = date.month.to_s.rjust(2, '0')
  day           = date.day.to_s.rjust(2, '0')
  issue_date    = "#{year}#{month}#{day}"
  news_xml      = "#{issue_date}_news_xml"
  preview_xml   = "#{issue_date}_preview_xml"

  puts 'sending it to News & Preview Xml.zip'
  ip        = '211.115.91.231'
  id        = 'naeil'
  pw        = 'sodlftlsans1!'
  entries = Dir.glob("#{xml_path}/**/*").sort
  Net::FTP.open(ip, id, pw) do |ftp|
    files = ftp.list
    ftp.mkdir(news_xml) unless ftp.list("/").any?{|dir| dir.match(/\s#{news_xml}$/)}
    entries.each do |name|
      base_name = File.basename(name)
      if File.directory? base_name
        # ftp.mkdir issue_date + "/#{base_name}"
        # ftp.mkdir base_name unless File.exists?(base_name)
        ftp.mkdir(base_name) unless ftp.list("/").any?{|dir| dir.match(/\s#{base_name}$/)}
      else
        File.open(name) { |file| ftp.putbinaryfile(file, news_xml + "/#{base_name}") }
      end
    end
  end
  entries = Dir.glob("#{preview_xml_path}/**/*").sort
  Net::FTP.open(ip, id, pw) do |ftp|
    files = ftp.list
    ftp.mkdir(preview_xml) unless ftp.list("/").any?{|dir| dir.match(/\s#{preview_xml}$/)}
    entries.each do |name|
      base_name = File.basename(name)
      if File.directory? base_name
        # ftp.mkdir issue_date + "/#{base_name}"
        # ftp.mkdir base_name unless File.exists?(base_name)
        ftp.mkdir(base_name) unless ftp.list("/").any?{|dir| dir.match(/\s#{base_name}$/)}
      else
        File.open(name) { |file| ftp.putbinaryfile(file, preview_xml + "/#{base_name}") }
      end
    end
  end
end

def send_mobile_preview_xml # 모바일용 지면보기 XML 전송 
  partial_folder          = partial_xml_path

  year          = date.year
  month         = date.month.to_s.rjust(2, '0')
  day           = date.day.to_s.rjust(2, '0')
  issue_date    = "#{year}#{month}#{day}"
  ip        = '211.115.91.68'
  id        = 'jimeun'
  pw        = 'sodlfwlaus2018!@#$'
  ftp_folder = "#{year}/#{month}/#{day}"
  entries = Dir.glob("#{mobile_preview_xml_path}/**/*").sort

  Net::FTP.open(ip, id, pw) do |ftp|
    # files = ftp.list
    # ftp.mkdir(ftp_folder) unless ftp.list("/").any?{|dir| dir.match(/\s#{ftp_folder}$/)}
    ftp.chdir(ftp_folder)
    # ftp.chdir("#{year}/#{month}/#{day}/")
    entries.each do |name|
      base_name = File.basename(name)
      dir_name  = File.dirname(name)
      dir_base_name = File.basename(dir_name)
      if File.directory? name
        # ftp.mkdir base_name.to_s unless File.exists?(base_name.to_s)
        ftp.mkdir(base_name) unless ftp.list.any?{|dir| dir.match(/\s#{base_name}$/)}
      else
        # puts "-------------- #{ftp_folder}/#{dir_base_name}/#{base_name}"
        File.open(name) { |file| ftp.putbinaryfile(file, "#{dir_base_name}/#{base_name}") }
      end
    end
  end
end

# check target ftp folder every 2 min for 1 hrs (2min x 50 = 1.5hrs)
def wait_for_xml_upload # 모바일용 지면보기 XML 콘테이너/업데이트정보 생성될 때 까지 2분간격 확인
  year          = date.year
  month         = date.month.to_s.rjust(2, '0')
  day           = date.day.to_s.rjust(2, '0')
  issue_date    = "#{year}#{month}#{day}"
  ip        = '211.115.91.68'
  id        = 'jimeun'
  pw        = 'sodlfwlaus2018!@#$'
  ftp_folder = "#{year}/#{month}/#{day}"
  found = false
  100.times do
    Net::FTP.open(ip, id, pw) do |ftp|
      ftp.chdir(ftp_folder)
      files_in_folder = ftp.list
      files_in_folder.each do |file|
        found = true if file.include?('Container.xml')
        break if found
      end
    end
    return true if found
    puts "+++++++ Container.xml 파일이 생성되지 않았습니다."
    sleep 120 # 2 min
  end
  found
end 

# 모바일용 지면보기 XML 콘테이너/업데이트정보 합성'
def merge_container_xml
  send_mobile_preview_xml # 모바일용 지면보기 XML 전송

  wait_for_xml_upload
  
  year          = date.year
  month         = date.month.to_s.rjust(2, '0')
  day           = date.day.to_s.rjust(2, '0')
  issue_date    = "#{year}#{month}#{day}"
  ip        = '211.115.91.68'
  id        = 'jimeun'
  pw        = 'sodlfwlaus2018!@#$'
  ftp_folder = "#{year}/#{month}/#{day}"

  Net::FTP.open(ip, id, pw) do |ftp|
    ftp.chdir(ftp_folder)
    ftp.getbinaryfile('updateinfo.xml', "#{partial_xml_path}/updateinfo.xml")
    ftp.getbinaryfile('Container.xml', "#{partial_xml_path}/Container.xml")

    # ++++++++ Container
    # container_base_path     = partial_folder + '/Container.xml'
    # container_partial_path  = partial_folder + '/partial_Container.xml'
    # if File.exist?(container_base_path) && File.exist?(container_partial_path)
    #   base_content          = File.open(container_base_path, 'r', &:read)
    #   after_count_change    = base_content.sub(/<PageList Count="22">/, '<PageList Count="24">')
    #   partial_content       = File.open(container_partial_path, 'r', &:read)
    #   page_24_and_afer      = /<Page ID="100124">.*<\/ContainerML>/m
    #   result = after_count_change.match(page_24_and_afer)
    #   final = result.pre_match + partial_content + result.to_s
    #   File.open(container_base_path, 'w') { |f| f.write final }
    #   FileUtils.rm(container_partial_path)
    # else
    #   puts 'No Container.xml or No partial_Container.xml !!!!'
    # end

    # ++++++++ updateinfo
    # updateinfo_base_path          = partial_folder + '/updateinfo.xml'
    # updateinfo_partial_path       = partial_folder + '/partial_updateinfo.xml'
    # if File.exist?(updateinfo_base_path) && File.exist?(updateinfo_partial_path)
    #   updateinfo_content          = File.open(updateinfo_base_path, 'r', &:read)
    #   after_info_change           = updateinfo_content.sub(/<UpdateCount>22<\/UpdateCount>/, '<UpdateCount>24</UpdateCount>')
    #   updateinfo_partial_content  = File.open(updateinfo_partial_path, 'r', &:read)
    #   info_page_24_and_afer       = /<PageKey>\d{8}_\d{6}24<\/PageKey>.*<\/UpdateInfo>/m
    #   info_result                 = after_info_change.match(info_page_24_and_afer)
    #   info_final                  = info_result.pre_match + updateinfo_partial_content + info_result.to_s
    #   File.open(updateinfo_base_path, 'w') { |f| f.write info_final }
    #   FileUtils.rm(updateinfo_partial_path)
    # else
    #   puts 'No updateinfo.xml or No partial_updateinfo.xml !!!!'
    # end
    # ftp.rename("#{ftp_folder}/.xml", "updateinfo.xml.old")
    # ftp.rename("#{ftp_folder}/Contaiupdateinfoner.xml", "Container.xml.old")
   
    # 합성만 하고 업로드 안하게 임시 주석처리 2018.10.01
    # ftp.putbinaryfile("#{partial_xml_path}/updateinfo.xml", 'updateinfo.xml')
    # ftp.putbinaryfile("#{partial_xml_path}/Container.xml", 'Container.xml')

    path = "#{partial_xml_path}/Container.xml"

    content = File.open(path, 'r'){|f| f.read}
    header_pattern = /(\<\?xml version="1.0".*?<PageList Count="\d{2}">)/m
    header_content = content.scan(header_pattern)
    header_content = header_content.first.first
    header_content.gsub!(/Count=\"\d{2}\"\>/, "Count=\"24\"\>\n")

    pattern = /(<Page ID="\d{6}">.*?<\/Page>)/m
    result = content.scan(pattern)
    page_num_pattern = /<Page ID="\d{4}(\d{2})"/m
    
    container_h = {}
    result.each do |page_chunk|
      # puts "page_chunk[0]:#{page_chunk[0]}"
      page_num = page_chunk[0].scan(page_num_pattern)
      # puts "page_num:#{page_num}"
      key = page_num.first[0]
      container_h[key] = page_chunk[0]
    end
    
    partcial_path = "#{partial_xml_path}/partial_Container.xml"
    partcial_content = File.open(partcial_path, 'r'){|f| f.read}
    result = partcial_content.scan(pattern)
    page_num_pattern = /<Page ID="\d{4}(\d{2})"/m
    
    
    partial_container_h = {}
    result.each do |page_chunk|
      puts "====="
      # puts "page_chunk[0]:#{page_chunk[0]}"
      page_num = page_chunk[0].scan(page_num_pattern)
      # puts "page_num:#{page_num}"
      key = page_num.first[0]
      partial_container_h[key] = page_chunk[0]
    end
    
    newsgo_partial_array = []
    24.times do |i|
      page        = (i + 1).to_s.rjust(2,"0")
      # page_div    = /<Page ID="\d{4}#{page}">.*?<\/Page>/m
      # result = news_go_partial_content.match(page_div)
      if partial_container_h[page]
        newsgo_partial_array << partial_container_h[page]
      else
        newsgo_partial_array << nil
      end
    end
    
    # base_content = File.open('Container.xml', 'r'){|f| f.read}
    # page_div      = /<Page ID="\d{4}21">.*?<\/Page>/m
    partial_array = []

    footer =<<EOF

  </PageList>
</ContainerML>
EOF
    
    24.times do |i|
      page        = (i + 1).to_s.rjust(2,"0")
      # result = base_content.scan(page_div)
      if container_h[page]
        partial_array << container_h[page]
      else
        partial_array << nil
      end
    
    end
    partial_array = partial_array.map.with_index do |e, i|
      if e.nil?
        newsgo_partial_array[i]
      else
        e
      end
    end
    
    s = header_content 
    s += partial_array.join("\n")
    s += footer
    
    puts s
    target = "#{partial_xml_path}/Container_merge.xml"
    File.open(target , 'w'){|f| f.write s}

    ftp.putbinaryfile("#{partial_xml_path}/Container_merge.xml", 'Container.xml')
    puts "+++++++ Container.xml 파일을 전송했습니다."
  end
end

# def send_mobile_preview_xml # 모바일용 지면보기 XML 전송

#   result = wait_for_xml_upload
#   if result
#     puts 'xml file upload found and proceeding merge'
#     merge_container_xml
#   else
#     puts 'xml file upload not found!!!'
#   end
# end


end