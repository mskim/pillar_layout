## 미사용 정리필요.
module IssueXmlWeb 
  extend ActiveSupport::Concern



  def get_newsgo_made_mobile_preview_xml
    newsgo_content_array = []
    pages.each do |page|
      if page.section_name = '전면광고'
        newsgo_content_array << page.all_container
      elsif page.page_number == 22 || page.page_number == 23 
        newsgo_content_array << page.all_container
      else
        newsgo_content_array << nil
      end
    end
    newsgo_content_array
  end

  def generated_pages_array
    pages = full_page_ad.map{|f| f.page_number}
    pages << 22
    pages << 23
    pages
  end

  def merge_mobile_page_container
    container_base_path   = partial_xml_path + '/Container.xml'
    base_content          = File.open(container_base_path, 'r', &:read)
    newsgo_partial_array  = get_newsgo_made_mobile_preview_xml

    header =<<EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <ContainerML>
      <WriteAndTime>2018-09-18T12:25:13</WriteAndTime>
      <NewsID>1</NewsID>
      <NewsName>내일신문</NewsName>
      <JeHoNum>4470</JeHoNum>
      <NewsDate>2018-09-18T00:00:00</NewsDate>
      <PanID>24</PanID>
    EOF

    footer =<<EOF
      </PageList>
    </ContainerML>
    EOF

    partial_array = []
    24.times do |i|
      @my_variable    = (i + 1).to_s.rjust(2,"0")
      page_div    = /<Page ID="\d{4}#{@my_variable}">.*?<\/Page>/m
      result = base_content.match(page_div)
      if result
        partial_array << result[0]
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

    final_container = header
    final_container += partial_array.join("\n")
    final_container += footer
    File.open(container_base_path, 'w') { |f| f.write final_container }
  end

  def save_mobile_page_updateinfo(updateinfo_xml_path)
    @year        = date.year
    @month       = date.month.to_s.rjust(2, '0')
    @day         = date.day.to_s.rjust(2, '0')
    @issue_date  = "#{@year}#{@month}#{@day}"
@update_info =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<UpdateInfo>
	<NewsDate>#{@issue_date}T00:00:00</NewsDate>
	<PubDate>#{@issue_date}T06:00:00</PubDate>
	<LastModifyDate>#{@issue_date}T12:25:13</LastModifyDate>
	<DownLoadList>
		<NewsClass version="1.00"/>
		<UpdateCount>24</UpdateCount>
		<PageKey>#{@issue_date}_01100101</PageKey>
		<PageKey>#{@issue_date}_01100102</PageKey>
		<PageKey>#{@issue_date}_01100103</PageKey>
		<PageKey>#{@issue_date}_01100104</PageKey>
		<PageKey>#{@issue_date}_01100105</PageKey>
		<PageKey>#{@issue_date}_01100106</PageKey>
		<PageKey>#{@issue_date}_01100107</PageKey>
		<PageKey>#{@issue_date}_01100108</PageKey>
		<PageKey>#{@issue_date}_01100109</PageKey>
		<PageKey>#{@issue_date}_01100110</PageKey>
		<PageKey>#{@issue_date}_01100111</PageKey>
		<PageKey>#{@issue_date}_01100112</PageKey>
		<PageKey>#{@issue_date}_01100113</PageKey>
		<PageKey>#{@issue_date}_01100114</PageKey>
		<PageKey>#{@issue_date}_01100115</PageKey>
		<PageKey>#{@issue_date}_01100116</PageKey>
		<PageKey>#{@issue_date}_01100117</PageKey>
		<PageKey>#{@issue_date}_01100118</PageKey>
		<PageKey>#{@issue_date}_01100119</PageKey>
		<PageKey>#{@issue_date}_01100120</PageKey>
		<PageKey>#{@issue_date}_01100121</PageKey>
		<PageKey>#{@issue_date}_01100122</PageKey>
		<PageKey>#{@issue_date}_01100123</PageKey>
		<PageKey>#{@issue_date}_01100124</PageKey>
	</DownLoadList>
</UpdateInfo>
EOF
    updateinfo_base_path  = partial_xml_path + '/updateinfo.xml'
    File.open(updateinfo_base_path, 'w') { |f| f.write @update_info }
  end

  def merge_container_xml
    ip          = '211.115.91.68'
    id          = 'jimeun'
    pw          = 'sodlfwlaus2018!@#$'
    year        = date.year
    month       = date.month.to_s.rjust(2, '0')
    day         = date.day.to_s.rjust(2, '0')
    issue_date  = "#{year}#{month}#{day}"

    ftp_folder              = "#{year}/#{month}/#{day}/"
    partial_folder          = partial_xml_path

    Net::FTP.open(ip, id, pw) do |ftp|
      ftp.chdir(ftp_folder)
      # ftp.getbinaryfile('updateinfo.xml', "#{partial_xml_path}/updateinfo.xml")
      ftp.getbinaryfile('Container.xml', "#{partial_xml_path}/Container.xml")
      # ++++++++ Container
      container_base_path     = partial_folder + '/Container.xml'
      if File.exist?(container_base_path) 
        merge_mobile_page_container
      else
        puts 'No Container.xml or No partial_Container.xml !!!!'
      end
      # ++++++++ updateinfo
      updateinfo_base_path  = partial_folder + '/updateinfo.xml'
      if File.exist?(updateinfo_base_path) 
        save_mobile_page_updateinfo(updateinfo_base_path)
      else
        puts 'No updateinfo.xml or No partial_updateinfo.xml !!!!'
      end
      # ftp.rename("#{ftp_folder}/.xml", "updateinfo.xml.old")
      # ftp.rename("#{ftp_folder}/Contaiupdateinfoner.xml", "Container.xml.old")
      ftp.putbinaryfile("#{partial_xml_path}/updateinfo.xml", 'updateinfo.xml')
      ftp.putbinaryfile("#{partial_xml_path}/Container.xml", 'Container.xml')
    end
  end

  def wait_for_xml_upload
    year          = date.year
    month         = date.month.to_s.rjust(2, '0')
    day           = date.day.to_s.rjust(2, '0')
    issue_date    = "#{year}#{month}#{day}"
    puts 'sending it tp Mobile Preview Xml.zip'
    ip        = '211.115.91.68'
    id        = 'jimeun'
    pw        = 'sodlfwlaus2018!@#$'
    # 다른곳에 먼저 테스트
    # ip        = '211.115.91.231'
    # id        = 'naeil'
    # pw        = 'sodlftlsans1!'
    ftp_folder = "#{year}/#{month}/#{day}"
    entries = Dir.glob("#{mobile_preview_xml_path}/**/*").sort
    Net::FTP.open(ip, id, pw) do |ftp|
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
          puts "-------------- #{ftp_folder}/#{dir_base_name}/#{base_name}"
          File.open(name) { |file| ftp.putbinaryfile(file, "#{dir_base_name}/#{base_name}") }
        end
      end
    end
    # result = wait_for_xml_upload
    # if result
    #   puts 'xml file upload found and proceeding merge'
    #   merge_mobile_container_xml
    # else
    #   puts 'xml file upload not found!!!'
    # end
  end

end