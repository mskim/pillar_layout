module PageSaveXml
  extend ActiveSupport::Concern

  def save_story_xml # 데스크탑 기사 XML
    if section_name == "전면광고"
      ad = ad_boxes.first
      ad.order = 1
      ad.save
      ad.save_ad_xml
    else
      working_articles.each do |article|
        article.save_story_xml
      end
      ad_boxes.each do |ad|
        ad.order = working_articles.length + 1
        ad.save_ad_xml
      end
    end
  end

  def save_preview_xml # 데스크탑 미리보기 XML
    date = issue.date
    @day = date.day.to_s.rjust(2,"0")
    @month = date.month.to_s.rjust(2,"0")
    @year = date.year % 100
    @date = "#{@year}#{@month}#{@day}"
    @page_number = page_number.to_s.rjust(2,"0")
    @filename = "#{issue.number}-#{@date}#{@page_number}"
    scale = 1.6
 
    header =<<~EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <PDFScrap version="1.0">
      <scraps zoom="120">\n
    EOF
    template =<<~EOF
    <Scrap title="<%= @filename %>_1_<%= @order %>.jpg" page="1" type="rectangle">
      <vertices><%= (@x_position*scale).round(0) %>;<%= (@y_position*scale).round(0) %>;<%=((@x_position + w.width)*scale).round(0) %>;<%= ((@y_position + w.height)*scale).round(0) %></vertices>
    </Scrap>
    EOF
    @issue_number = issue.number
    @page_number = page_number
 
    article_map_path = "#{Rails.root}/public/1/issue/#{issue.date.to_s}/page_preview"
    article_map = header
    working_articles.sort_by{|x| x.order}.each do |w|
      @order = w.order - 1
      @x_position = publication.left_margin + w.x
      @y_position = publication.top_margin + w.y
      erb = ERB.new(template)
      article_map += erb.result(binding) + "\n"
      article_map_jpg_image_path = article_map_path + "/#{@filename}_1_#{@order}.jpg"
      # system("cp #{w.jpg_path} #{article_map_jpg_image_path}")
      FileUtils.mkdir_p(article_map_path) unless File.exist?(article_map_path)
      FileUtils.cp(w.jpg_path, article_map_jpg_image_path)
 
    end
    ad_boxes.each do |w|
      @order = working_articles.length
      @x_position = publication.left_margin + w.x
      @y_position = publication.top_margin + w.y
      erb = ERB.new(template)
      article_map += erb.result(binding) + "\n"
      article_map_jpg_image_path = article_map_path + "/#{@filename}_1_#{@order}.jpg"
      FileUtils.mkdir_p(article_map_path) unless File.exist?(article_map_path)
      FileUtils.cp(w.jpg_path, article_map_jpg_image_path)
      # system("cp #{w.jpg_path} #{article_map_jpg_image_path}")
    end
    article_map += "</scraps><pdf filename='#{@filename}.PDF'/></PDFScrap>"
    system("mkdir -p #{article_map_path}") unless File.exist?(article_map_path)
    File.open(article_map_path + "/#{@filename}.xml", 'w'){|f| f.write article_map}
    system("cp #{pdf_path} #{article_map_path}/#{@filename}.pdf")
   end

  def page_info
    page_number.to_s.rjust(2,"0")
  end

  def mobile_page_preview_path
    "#{Rails.root}/public/1/issue/#{issue.date.to_s}/mobile_page_preview/1001#{page_info}"
  end

  def xml_section_name
    if page_number == 22 || page_number == 23
      "논설#{page_number - 21}"
    else
      section_name
    end
  end  

  def all_container # 모바일 지면보기 XML용 콘테이너
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    @page_key         = "#{year}#{month}#{day}_011001#{page_info}"

    container_xml_page_id=<<EOF
    <Page ID="1001<%= page_info %>">
      <PageKey><%= @page_key %></PageKey>
      <PageTitle>#{xml_section_name}</PageTitle>
      <PaperSize>A2</PaperSize>
EOF
    page_container_xml = ""
    container_xml = ""
    container = ""
    # container_xml_page = ""
    erb=ERB.new(container_xml_page_id)
    container_xml += erb.result(binding)
    working_articles.sort_by{|x| x.order}.each do |w|
      page_container_xml += w.xml_group_key_template
    end
    ad_boxes.each do |w|
      page_container_xml += w.xml_group_key_template
    end
    # container += container_xml  + "\n" + page_container_xml
    container += container_xml
    container + page_container_xml + "    </Page>" + "\n"
  end

  def updateinfo
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    @page_key         = "#{year}#{month}#{day}_011001#{page_info}"
    page_key=<<EOF
    <PageKey><%= @page_key %></PageKey>
EOF
    erb=ERB.new(page_key)
    erb.result(binding)
  end

  def save_mobile_preview_xml # 모바일 지면보기 XML
    # puts "++++++++++++ page_number:#{page_number}"
    default_time      = "00:00:00"
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    # w_updated_at = working_articles.first.updated_at
    updated_date      = "#{year}-#{month}-#{day}"
    updated_time      = updated_at.strftime("%H:%M:%S")
    @date_id          = updated_date
    @day_info         = "#{year}년#{month}월#{day}일"
    @media_info       = publication.name
    date = issue.date
    @day = date.day.to_s.rjust(2,"0")
    @month = date.month.to_s.rjust(2,"0")
    @year = date.year
    @date = "#{@year}#{@month}#{@day}"
    @filename = "#{@date}_011001#{page_info}"
    @article_filename = "#{@date}.011001#{page_info}"
    @jeho_num         = issue.number
    @news_date        = "#{updated_date}T#{default_time}"
    @news_meun_2        = page_number.to_s.rjust(2,"0")
    @news_meun        = page_number
    @issue_title      = section_name
    @writre_and_time  = "#{updated_date}T#{updated_time}"
    @page_key         = "#{year}#{month}#{day}_011001#{page_info}"
    @article_count    = working_articles.length

    system("mkdir -p #{mobile_page_preview_path}") unless File.exist?(mobile_page_preview_path)
    system("cp #{jpg_path} #{mobile_page_preview_path}")
    resize_name = "#{@date}_011001#{page_info}"
    system "cd #{mobile_page_preview_path} && convert section.jpg -resize 2300x3191  #{resize_name}.jpg"
    system "cd #{mobile_page_preview_path} && convert section.jpg -resize 1856x2575  #{resize_name}c.jpg"
    system "cd #{mobile_page_preview_path} && convert section.jpg -resize 1150x1595  #{resize_name}b.jpg"
    system "cd #{mobile_page_preview_path} && convert section.jpg -resize 640x888  #{resize_name}a.jpg"
    system "cd #{mobile_page_preview_path} && convert section.jpg -resize 160x222  #{resize_name}s.jpg"
    system "rm #{mobile_page_preview_path}/section.jpg"

    mobile_layout_ml =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
  <MobileLayoutML>
    <PageInfo>
      <NewsPlus Program="NewsLayout" Version="12.0"/>
      <NewsID>1</NewsID>
      <NewsName>내일신문</NewsName>
      <JeHoNum><%= @jeho_num %></JeHoNum>
      <NewsDate><%= @news_date %></NewsDate>
      <NewsPan>10</NewsPan>
      <NewsSectionID SectionName="A" DisplayName="A">1</NewsSectionID>
      <NewsMeun><%= @news_meun %></NewsMeun>
      <Page>A<%= @news_meun %></Page>
      <Title><%= @issue_title  %></Title>
      <WriteAndTime><%= @writre_and_time %></WriteAndTime>
      <LogOnUser/>
      <PageID>1001<%= @news_meun_2 %></PageID>
      <PageKey><%= @page_key %></PageKey>
      <ArticleCount><%= @article_count %></ArticleCount>
      <PaperSize>A2</PaperSize>
    </PageInfo>
EOF
     size_array = %w[CoordinateListReal CoordinateListOrg CoordinateListA CoordinateListB CoordinateListC]
     # scale_array = [4.128, 1.148, 2.064, 3.332, 0.286]
     # scale_array = [19.790, 2.023, 0.558, 1, 1.627]
     scale_array = [20.423, 2.087, 0.575, 1.032, 1.679]
     # scale_array = [20.5, 2.1, 0.6, 1.1, 1.7]


    map_component=<<EOF
      <<%= name %>>
        <List><%= (@x1 * scale).round(0) %>,<%= (@y1 * scale).round(0) %>,<%= (@x2 * scale).round(0) %>,<%= (@y2 * scale).round(0) %></List>
        <Polygon><%= (@x1 * scale).round(0) %>,<%= (@y1 * scale).round(0) %>;<%= (@x2 * scale).round(0) %>,<%= (@y1 * scale).round(0) %>;<%= (@x2 * scale).round(0) %>,<%= (@y2 * scale).round(0) %>;<%= (@x2 * scale).round(0) %>,<%= (@y2 * scale).round(0) %>;<%= (@x1 * scale).round(0) %>,<%= (@y2 * scale).round(0) %>;</Polygon>
      </<%= name %>>
EOF

      mobile_layout = ""
      erb=ERB.new(mobile_layout_ml)
      mobile_layout += erb.result(binding)

      working_articles.sort_by{|x| x.order}.each do |w|
        @order = (w.order).to_s.rjust(2,'0')
        @x1 = (publication.left_margin + w.x)
        @x2 = (@x1 + w.width)
        # if (page_number == 22 || page_number == 23) && (@order == 1 || @order == 2)
        if (page_number == 22 || page_number == 23) && (@order == 1 || @order == 2)
          # puts "page_number:#{page_number}"
          # puts "@order:#{@order}"
          @y1 = (publication.top_margin + w.y + 55.073)
          @y2 = (@y1 + w.height - 55.073 + w.extended_line_height)
          # puts "@y2:#{@y2}"
          # puts "w.extended_line_height:#{w.extended_line_height}"

        else
          # puts "page_number:#{page_number}"
          # puts "@order:#{@order}"
          @y1 = (publication.top_margin + w.y)
          @y2 = (@y1 + w.height)
        end
        scale_map=""
        size_array.each_with_index do |name, i|
          scale = scale_array[i]
          erb=ERB.new(map_component)
          scale_map += erb.result(binding)
        end
        # w.covert_euckr_not_suported_chars
        mobile_layout += "  <Article>" + "\n" + w.mobile_preview_xml_article_info
        mobile_layout += "    <MapComponent>" + "\n" + scale_map + "    </MapComponent>" + "\n"
        mobile_layout += w.mobile_preview_xml_three_component
        article_map_jpg_image_path = mobile_page_preview_path + "/#{@article_filename}0000#{@order}.jpg"
        system("cp #{w.jpg_path} #{article_map_jpg_image_path}")
    end

    ad_boxes.each do |w|
      @order = (working_articles.length + 1).to_s.rjust(2,'0')
      @x1 = (publication.left_margin + w.x)
      @x2 = (@x1 + w.width)
      @y1 = (publication.top_margin + w.y)
      @y2 = (@y1 + w.height)
      scale_map = ""
      size_array.each_with_index do |name, i|
        scale = scale_array[i]
        erb=ERB.new(map_component)
        scale_map += erb.result(binding)
      end
      # erb=ERB.new(mobile_layout_ml)
      # mobile_layout += erb.result(binding)
      mobile_layout += "  <Article>" + "\n" + w.mobile_preview_xml_article_info
      mobile_layout += "    <MapComponent>" + "\n" + scale_map + "    </MapComponent>" + "\n"
      mobile_layout += w.mobile_preview_xml_component

      # erb_map = ERB.new(map_component)
      # article_map += erb_map.result(binding)
      article_map_jpg_image_path = mobile_page_preview_path + "/#{@article_filename}0000#{@order}.jpg"
      system("cp #{w.jpg_path} #{article_map_jpg_image_path}")
    end


     # mobile_layout_ml += article_info
     mobile_layout += "\n" + " </MobileLayoutML>"
     working_articles.each do |article|
       article.save_mobile_xml_image
     end

    File.open(mobile_page_preview_path + "/#{@filename}.xml", 'w'){|f| f.write mobile_layout}
    system("cp #{pdf_path} #{mobile_page_preview_path}/#{@filename}.pdf")
    system("cp #{mobile_page_preview_path} #{mobile_page_preview_path}/#{@filename}.pdf")
  end

  # def container_xml_page
  #   # page_info        = page_number.to_s.rjust(2,"0")
  #
  # end

end