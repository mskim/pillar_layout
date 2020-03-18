module ArticleSaveXml
  extend ActiveSupport::Concern


## 뉴스 / 지면보기 XML 생성관련 소스 분리 2018-12-27 DaNiel

   def find_code_name(code)
    a =      [['국회/정당', 1201], ['청와대', 1202], ['피플', 1205], ['지방자치', 1300], ['금융', 1401], ['산업', 1402], ['재정', 1403], ['글로벌경제', 1502], ['피플', 1404], ['지구촌소식', 1501], ['외교/국방', 1203], ['통일', 1204], ['피플', 1503], ['연합뉴스', 1000], ['사건/사고', 1601], ['법률',1602], ['교육',1603], ['노동', 1604], ['환경',1605], ['보건복지', 1606], ['시민사회', 1607], ['포토뉴스',1608], ['피플',1609], ['도서관', 1701], ['출판/서평', 1702], ['예술', 1704], ['피플', 1706], ['여론조사', 3201], ['기획연재', 3201]]
    a.each do |code_a|
      return code_a[0] if code_a[1] == code
    end
    nil
  end 

  def filter_to_title(title)
    return unless title
    title.strip!
    title.gsub!(/\n\n/, "\n")
    title.gsub!(/^\n/, "")
    title.gsub!(/\n$/, "")
    title.gsub!(/\u3000/, "")
    title.gsub!(/\···/, "⋯")
    title.gsub!(/ {2,8}/, " ")
    title.gsub!("\u2027", "・")
    title.gsub!("\u0387", "・")
    title.gsub!("\u00b7", "・")
    title.gsub!("\u2219", "・")
    title
  end

  def filter_to_quote(text)
    return unless text
    text.gsub!(/^\"/, "“")  
    text.gsub!(/\—/, "-")  
    text.gsub!(/^\"\'/, "“‘")
    text.gsub!(/^\“\'/, "“‘")
    text.gsub!(/^\'/, "‘")
    text.gsub!(/\(\"/, "(“")
    text.gsub!(/\(\'/, "(‘")
    text.gsub!(/\)\"/, ")”")
    text.gsub!(/\)\'/, ")’")
    text.gsub!(/\.\"/, ".”")
    text.gsub!(/\.\'/, ".’")
    text.gsub!(/\"$/, "”")
    text.gsub!(/\'$/, "’")
    text.gsub!(/\*\"/, "*“")
    text.gsub!(/\*\◆\"/, "*◆“")
    text.gsub!(/\*\s\◆\"/, "*◆“")
    text.gsub!(/\*\s\◆/, "*◆")
    text.gsub!(/\*\◆\'/, "*◆‘")
    text.gsub!(/\"\s\=\*/, "” =*")
    text.gsub!(/\s\=\s\*/, " =*")
    text.gsub!(/\'\s\=\*/, "’ =*")
    text.gsub!(/\s\"/, " “")
    text.gsub!(/\s\'/, " ‘")
    text.gsub!(/\"\s/, "” ")
    text.gsub!(/\"\,\s/, "”, ")
    text.gsub!(/\'\,\s/, "’, ")    
    text.gsub!(/\b\"\b/, "”")
    text.gsub!(/\b\'\b/, "’")
    text.gsub!(/\b\"/, "”")
    text.gsub!(/\b\'/, "’")
    text.gsub!(/\"\s/, "” ")
    text.gsub!(/\'\s/, "’ ")
    text.gsub!(/\–/, "-")
    text
  end

  def filter_to_markdown(body_text)
    return unless body_text
    body_text.strip!
    # body_text.gsub!(/\s\s/, " ")
    # body_text.gsub!(/^\n\n/, "\n")
    body_text.gsub!(/\u200B/, "")
    body_text.gsub!(/^(\^|-\s)/, "")
    body_text.gsub!(/^\t/, "")
    body_text.gsub!(/^\n/, "")
    body_text.gsub!(/^\s/, "")
    body_text.gsub!(/^\u3000/, "")
    body_text.gsub!(/\u3000/, " ")
    body_text.gsub!(/^\s*\n/m, "\n")
    body_text.gsub!(/^\s*#/, '#' )
    body_text.gsub!(/^\n/, "")
    body_text.gsub!(/(\n|\r\n)+/, "\n\n")
    # body_text.gsub!(/(\n)+/, "\n\n")
    # body_text.gsub!(/[.]\s\s\s+/, ".")
    # body_text.gsub!(/\.$\n\n/, ".")
    body_text.gsub!(/^\./, "")
    body_text.gsub!(/ {2,8}/, " ")
    body_text.gsub!("\u2024", ".")
    body_text.gsub!("\u00A0", " ")
    body_text.gsub!("\u30fb", "·")
    body_text.gsub!("\u2027", "·")
    body_text.gsub!("\u0387", "·")
    body_text.gsub!("\u2022", "·")
    body_text
  end

  def to_markdown_para
    # body.gsub!(/\s\s/, /\s/)
    body.gsub!(/^(\^|-\s)/, "")
    body.gsub!(/^\t/, "")
    body.gsub!(/^\n\n/, "")
    body.gsub!(/^\u3000/, "")
    body.gsub!(/^\s*\n/m, "\n")
    body.gsub!(/^\s*#/, '#' )
    # body.gsub!(/$(\n|\r\n)+/, "\n\n" )
    # body.gsub!(/(\n|\r\n)+/, "\n\n")
    body.gsub!(/$(\n)+/, "\n\n" )
    body.gsub!(/(\n)+/, "\n\n")
    self.save
  end
  
  def convert_euckr_not_suported_chars
    # return unless title
    # return unless body
    # return unless subtitle
    # return unless subject_head
    # return unless boxed_subtitle_text
    # images.first.caption_title.gsub!("\u200B", "")
    # images.first.caption.gsub!("\u200B", "")
    # images.first.source.gsub!("\u200B", "")
    if title && title != ""
    title.strip!
    title.gsub!("\u200B", "")
    title.gsub!("\u22EF", "&ctdot;")
    title.gsub!("\u2027", "·")
    title.gsub!("\u2024", ".")
    title.gsub!("\u003C", "&lt;")
    title.gsub!("\u003E", "&gt;")
    title.gsub!("\u2014", "-")
    title.gsub!("\u2013", "-")
    title.gsub!("\u5e26", "&#24102;")
    title.gsub!("\u2219", "&#8729;")
    title.gsub!("\u56fd", "&#22269;")
    # title.gsub!("\u0026", "&amp;")
    # title.gsub!("\u22ef", "&#8943;")
    title.gsub!("\u00A0", " ")
    title.gsub!("\u2031", "&#8241;")
    title.gsub!("\u30fb", "·")
    title.gsub!("\u223c", "~")
    title.gsub!("\u2003", "")
    end
    if subtitle && subtitle != ""
    subtitle.gsub!("\u2027", "·")
    # subtitle.gsub!("\u22EF", "&#8943;")
    subtitle.gsub!("\u22EF", "&ctdot;")
    subtitle.gsub!("\u200B", "")
    subtitle.gsub!("\u2024", ".")
    subtitle.gsub!("\u2013", "-")
    subtitle.gsub!("\u30fb", "·")
    subtitle.gsub!("\u223c", "~")
    subtitle.gsub!("\u2003", "")
    end
    if reporter && reporter != ""
    reporter.gsub!("\u200B", "")
    reporter.gsub!("\u2024", ".")
    end
    if subject_head && subject_head != ""
    subject_head.gsub!("\u2024", ".")
    subject_head.gsub!("\u200B", "")
    subject_head.gsub!("\u30fb", "·")
    subject_head.gsub!("\u223c", "~")
    end
    if boxed_subtitle_text && boxed_subtitle_text != ""
    boxed_subtitle_text.gsub!("\u2470", "&#9328;") 
    boxed_subtitle_text.gsub!("\u22EF", "&ctdot;")
    boxed_subtitle_text.gsub!("\u2024", ".")
    boxed_subtitle_text.gsub!("\u30fb", "·")
    boxed_subtitle_text.gsub!("\u223c", "~")
    end
    if body && body != ""
    body.gsub!("\u2031", "&#8241;")
    body.gsub!("\u25b8", "&#9656;")
    body.gsub!("\u3007", "&#12295;")
    body.gsub!("\ud594", "&#54676;")
    body.gsub!("\u4F18", "&#20248;")
    body.gsub!("\u5014", "&#20500;")
    body.gsub!("\u5733", "&#22323;")
    body.gsub!("\u22EF", "&ctdot;")
    body.gsub!("\u200B", "")
    body.gsub!("\u5733", "&#22323;")
    body.gsub!("\u2024", "&#8228;")
    body.gsub!("\u9785", "&#38789;")
    body.gsub!("\u9ee5", "&#40677;")
    body.gsub!("\ud5a1", "&#54689;")
    # body.gsub!("\u00b7", "\u30fb")
    body.gsub!("\u6DB8", "&#28088;")
    body.gsub!("\u9B92", "&#39826;")
    body.gsub!("\u2022", "·")
    body.gsub!("\u2027", "·")
    body.gsub!("\u0387", "·")
    body.gsub!("\u30fb", "·")
    body.gsub!("\u00A0", " ")
    body.gsub!("\u2003", " ")
    body.gsub!("\u2014", "-")
    body.gsub!("\u2013", "-")
    body.gsub!("\u2043", "-")
    body.gsub!("\u223c", "~")
    body.gsub!("\u003C", "&lt;")
    body.gsub!("\u003E", "&gt;")
    body.gsub!("\uFF62", "&#65378;")
    body.gsub!("\uFF63", "&#65379;")
    body.gsub!("\u2613", "&#9747;")
    body.gsub!("\u9752", "&#38738;")
    body.gsub!("\u5d1b", "&#23835;")
    body.gsub!("\uCAD2", "&#51922;")
    body.gsub!("\uFF65", "&#65381;")
    body.gsub!("\u302e", "&#12334;")
    body.gsub!("\u5e26", "&#24102;")
    body.gsub!("\u2219", "&#8729;")
    # body.gsub!("\u0026", "&amp;")
    body.gsub!("\u8f9f", "&#36767;")
    # body.gsub!("\u22ef", "&#8943;")
    body.gsub!("\u25fc", "&#9724;")
    body.gsub!("\u00FC", "&#252;")
    body.gsub!("\u924F", "&#37455;")
    body.gsub!("\u939B", "&#37787;")
    body.gsub!("\u5c14", "&#23572;")
    body.gsub!("\ucc1f", "&#52255;")
    body.gsub!("\u8B8E", "&#35726;")
    body.gsub!("\u56fd", "&#22269;")
    body.gsub!("\u9A91", "&#39569;")
    body.gsub!("\uB9DF", "&#47583;")

    end
  end

  def newsml_issue_path
    "#{Rails.root}/public/1/issue/#{issue.date}/newsml"
  end
  
  def image_source
    if page_number == 22
      if kind == '기고'
        person = OpinionWriter.where(name:reporter).first
        name = person.name
        filtered_name = name
        filtered_name = name.split("_").first if name.include?("_")
        filtered_name = name.split("=").first if name.include?("=")
        # puts "filtered_name : #{filtered_name}"
        return opinion_image_path + "/#{filtered_name}.jpg"
      elsif kind == '사설'
        person = Profile.where(name:reporter).first
        if person
          name = person.name
          filtered_name = name
          filtered_name = name.split("_").first if name.include?("_")
          filtered_name = name.split("=").first if name.include?("=")
          return profile_image_path + "/#{name}.jpg"
        else
          return nil
        end
      end
    elsif page_number == 23
      if kind == '기고'
        person = OpinionWriter.where(name:reporter).first
        name = person.name
        filtered_name = name
        filtered_name = name.split("_").first if name.include?("_")
        filtered_name = name.split("=").first if name.include?("=")
        return opinion_image_path + "/#{filtered_name}.jpg"
      elsif kind == '사설'
        return nil
        # person = reporter_from_body
        # name = person.gsub(" ","")[0..2]
        # return opinion_image_path + "/#{name}.jpg"
      end
    end
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    hour  = updated_at.hour.to_s.rjust(2, "0")
    min   = updated_at.min.to_s.rjust(2, "0")
    sec   = updated_at.sec.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")
    updated_date      = "#{year}#{month}#{day}"
    # @page_info        = page_number.to_s.rjust(2,"0")
    # @jeho_info        = issue.number
    # @date_id          = updated_date
    # @photo_item       = "#{@date_id}_#{@jeho_info}_#{@page_info}_#{two_digit_ord}p.jpg"
    # @graphic_item       = "#{@date_id}_#{@jeho_info}_#{@page_info}_#{two_digit_ord}g.jpg"
  end
  
  def two_digit_ord
    order.to_s.rjust(2, "0")
  end

  def story_xml_filename
    date_without_minus = issue.date.to_s.gsub("-","")
    two_digit_page_number = page_number.to_s.rjust(2, "0")
    "#{date_without_minus}.011001#{two_digit_page_number}0000#{two_digit_ord}.xml"
  end

  def save_story_xml
    FileUtils.mkdir_p(newsml_issue_path) unless File.exist? newsml_issue_path
    path = "#{newsml_issue_path}/#{story_xml_filename}"
    # story_xml.encode("utf-8").force_encoding("ANSI")
    # story_xml.gsub!("\u200B", "&#8203;")
    story_xml.gsub!("\u2027", "&#8231;")
    story_xml.gsub!("\u4F18", "&#20248;")
    story_xml.gsub!("\u246F", "&#9327;")
    # story_xml.gsub!("\u22EF", "&#8943;")
    story_xml.gsub!("\u2024", "&#8228;")
    convert_euckr_not_suported_chars
    # puts story_xml =~/\u4F18/ 
    # puts story_xml.dump
    File.open(path, 'w:euc-kr'){|f| f.write story_xml}
    # File.open(path, 'w:utf-8'){|f| f.write story_xml}
    save_xml_image 
  end

  def save_xml_image    
    source = image_source
    return if source.nil?
    target = newsml_issue_path + "/#{@photo_item}"
    system("cp #{source} #{target}")
    images.each do |i|
      ext = File.extname(i.image_path)
      image_name = File.basename(i.image_path)
      if ext == ".jpg"
        system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 540 #{image_name} --out #{newsml_issue_path}/#{@photo_item}")
      elsif ext == ".pdf"
        system("cd #{issue.path}/images/ && convert -density 300 -resize 540 #{image_name} #{newsml_issue_path}/#{@photo_item}")
        # original_pdf = File.open("#{image_name}", 'rb').read
        # image = Magick::Image::from_blob(original_pdf) do
        #   self.format = 'PDF'
        #   self.quality = 100
        #   self.density = 300
        # end
        # image[0].format = 'JPG'
        # image[0].to_blob
        # image[0].write("#{original_pdf}".jpg)
        # system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 540 #{original_pdf} --out #{newsml_issue_path}/#{@photo_item}")
      end
    end
    graphics.each do |g|
      ext = File.extname(g.image_path)
      image_name = File.basename(g.image_path)
      if ext == ".jpg"
        system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 540 #{image_name} --out #{newsml_issue_path}/#{@graphic_item}")
      elsif ext == ".pdf"
        system("cd #{issue.path}/images/ && convert -density 300 -resize 540 #{image_name} #{newsml_issue_path}/#{@graphic_item}")
      # elsif ext == ".pdf"
        # original_pdf = File.open("#{image_name}", 'rb').read
        # image = Magick::Image::from_blob(original_pdf) do
        #   self.format = 'PDF'
        #   self.quality = 100
        #   self.density = 300
        # end
        # image[0].format = 'JPG'
        # image[0].to_blob
        # image[0].write("#{original_pdf}".jpg)
        # system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 540 #{original_pdf} --out #{newsml_issue_path}/#{@photo_item}")
      end
    end
  end

  def reporter_from_body
    # return unless reporter
    body.match(/^# (.*)/) if body && body !=""
    $1.to_s.sub("# ", "")
  end

  def story_xml # 내일닷컴(데스크탑용) 기사 xml 생성
    story_erb_path = "#{Rails.root}/public/1/newsml/story_xml.erb"
    story_xml_template = File.open(story_erb_path, 'r'){|f| f.read}
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    hour  = created_at.hour.to_s.rjust(2, "0")
    min   = created_at.min.to_s.rjust(2, "0")
    sec   = created_at.sec.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")
    updated_date      = "#{year}#{month}#{day}"
    # updated_time      = "#{hour}#{min}#{sec}+0900"
    updated_time      = "100000+0900"
    @date_and_time    = "#{updated_date}T#{updated_time}"
    @date_id          = updated_date
    @news_key_id      = "#{updated_date}.011001#{page_info}0000#{two_digit_ord}"
    @day_info         = "#{year}년#{month}월#{day}일"
    @media_info       = publication.name
    # @edition_info     = page_number.to_s.rjust(2,"0")
    # @page_info        = publication.paper_size
    @page_info        = page_number.to_s.rjust(2,"0")
    @jeho_info        = issue.number
    # if page.section_name = '오피니언'
    #   @news_title_info = '논설'
    # else
    #   @news_title_info  = page.section_name
    # end
    @news_title_info  = page.section_name
    # reporter_record   = Reporter.where(name:reporter).first
    # if reporter_record
    #   @post             = reporter_record.reporter_group.name
    #   @gija_id          = email.split("@").first
    #   @email            = email
    # else
    #   @post             = "소속팀"
    #   @gija_id          = "기자아이디"
    #   @email            = "기자이메일"
    # end
    if reporter && reporter != ""  
     @name       = reporter
    else  
     @name       = reporter_from_body.gsub(/\^$/){""}
    end
    author              = reporter_from_body
    if author && page_number != 22
      @name             = reporter_from_body.gsub(/\^$/){""}.split(" ")[0]
      @post             = "소속팀"
      @author_email     = reporter_from_body.gsub(/\^$/){""}.split(" ")[2] 
      @author_id        = @author_email.split("@").first if @author_email
      # @by_line          =  "#{@name} 기자 #{@author_email}"
      @by_line          =  author
    else
      @name             = reporter
      @post             = "소속팀"
      @author_id        = "기자아이디"
      @author_email     = "기자이메일"
    end

     # if @name =~/_/
      # @name = @name.split("_")[0]
      # end
    opinion_writer  = OpinionWriter.where(name:reporter).first
    if opinion_writer
      @name        = opinion_writer.name if opinion_writer.name
      @work        = opinion_writer.work if opinion_writer.work
      @position    = opinion_writer.position if opinion_writer.position
      if @name =~/_/
        @name = @name.split("_")[0]
      elsif @name =~/=/
        @name = @name.split("=")[0]
      elsif @name =~/-/
        @name = @name.split("-")[0]
      end       
      # @by_line_body   = "<br><br>#{@name} #{@work} #{@position}"
      @by_line_body   = ""
      @by_line        = "#{@name} #{@work} #{@position}"
      # @by_line        = reporter_from_body
      @caption        = "#{@name} #{@work} #{@position}"
    end
    # reporter_record   = Reporter.where(name:reporter).first
    if page_number == 22 && order == 2
      profile         = Profile.where(name:@name).first
      if profile
        @name        = profile.name
        @work        = profile.work if profile.work
        @position    = profile.position if profile.position
        if @name =~/_/
          @name = @name.split("_")[0]
        elsif @name =~/=/
          @name = @name.split("=")[0]
        elsif @name =~/-/
          @name = @name.split("-")[0]
        end
        # @by_line_body   = "<br><br>#{@name} #{@work} #{@position}"
        @by_line_body   = ""
        @by_line        = "#{@name} #{@work} #{@position}"
        @caption        = "#{@name} #{@work} #{@position}"
      end
    end
    if page_number == 23 && order == 2
      @name          = reporter_from_body
      @by_line       = reporter_from_body
      @by_line_body  = "" 
      reporter       = Reporter.where(name: @name).first
      @gija_email    = reporter.email if reporter
      @caption       = reporter_from_body
    end
    @section_name_code = section_name_code
    if subject_head && subject_head != ""
      subject_head.strip! 
      @name_plate       = eliminate_size_option(subject_head)
    else
      # r = OpinionWriter.where(name: reporter).first
      # puts r
      if page_number == 22 || page_number == 23
        @subject_ex_code = opinion_writer.category_code 
        @subject_ex_name = opinion_writer.title
        @name_plate = opinion_writer.title
      end
    end 
    @subject_ex_code = story.category_code if story && story.category_code && story.category_code != ""
    @subject_ex_code = subcategory_code if subcategory_code && subcategory_code != ""
    # if page_number == 1
    #   @subject_ex_code = category_code
    #   @subject_ex_name = ""
    # end
    # @subject_ex_name  = @name_plate.gsub(/\[(.*)\]/){"#{$1}"} if @name_plate && @name_plate !=""  
    @subject_ex_name  = find_code_name(story.category_code.to_i) if story && story.category_code && story.category_code != ""
    @subject_ex_name  = find_code_name(subcategory_code.to_i) if subcategory_code && subcategory_code != ""
    if page_number == 1 || page_number == 10
      @money_status = "0"
    # elsif page_number == 20 || page_number == 21
    #   @money_status     = story.price.to_i if story && story.price && story.price != ""
    elsif page_number == 22
      puts "kind : #{page_number } #{kind} #{@money_status}"
      if kind == '사설'
        if subject_head == '기고'
          @subject_ex_code = 2401
          @subject_ex_name = '기고'
          @money_status = "0"
        elsif subject_head == '정치시평'
          @subject_ex_code = 2201
          @subject_ex_name = '정치시평'
          @money_status = "30"
        elsif subject_head == '신문로'
          @subject_ex_code = 2103
          @subject_ex_name = '신문로'
          @money_status = "30"
        end
      elsif kind == '기고'
        @money_status = "30"
        if opinion_writer.title == '신문로'
          @subject_ex_code = 2103
          @subject_ex_name = '신문로'
        elsif opinion_writer.title == '경제시평'
          @subject_ex_code = 2202
          @subject_ex_name = '경제시평'
        elsif opinion_writer.title == '중국시평'
          @subject_ex_code = 2203
          @subject_ex_name = '중국시평'
        end
      end
    elsif page_number == 23
      if kind == '사설'
        @subject_ex_code = 2101
        @subject_ex_name = '내일시론'
        @money_status = "30"
      else 
        @money_status = "30"
      end
      @money_status = "30"
    end
    @gisa_key         = "#{@date_id}991#{@page_info}#{two_digit_ord}"
    # reporter_from_body = 
    if body && body != ""
      @body_content     = body.gsub(/\n\n^\#\#\#\#(.*)/){"<!-- #{$1} -->"}
      @body_content     = @body_content.gsub(/^\#\s(.*)/){""}  
      # @body_content     = @body_content.gsub(/^\#\#\#\#(.*)\^\n/){"<!-- #{$1} -->"} 
      @body_content     = @body_content.gsub(/^\#\#\#(.*)/){"<b>#{$1}</b><br><br>"} 
      @body_content     = @body_content.gsub(/^\#\#(.*)/){"<b>#{$1}</b>"} 
      @body_content     = @body_content.gsub(/^\*(.*)=\*/){"<b>#{$1}</b> = "} 
      @body_content     = @body_content.gsub(/^\*(.*)\*/){"<b>◆#{$1}</b> = "} 
      @body_content     = @body_content.gsub(/^\*\*(.*)\*\*/){"<b>#{$1}</b>"} 
      @body_content     = @body_content.gsub(/\*\*(.*)\*\*/){"<b>#{$1}</b>"} 
      @body_content     = @body_content.gsub(/\^$/){""} 
      @body_content     = @body_content.gsub(/\n\n/){"<br><br>"} 
      @body_content     = @body_content.gsub(/\r\n/){"<br><br>"} 
      @data_content     = @body_content.gsub(/<br><br>\z/){""} 
      # @data_content     = @body_content.gsub(/\n\n\z/){""} 
    end
    # title.gsub!("\u2024", "")
    # puts "=================="
    # if body.include?("\u2024")
    #   puts "body"
    # elsif title.include?("\u2024")
    #   puts "title"
    # end
    # if quote && quote.include?("\u2024")
    #   puts "quote"
    # end
    if images.length > 0 
      @image          = images.first
      @caption        = ""
      @caption        = "#{@image.caption_title} | " if @image.caption_title && @image.caption_title != ""
      @caption        += "#{@image.caption} " if @image.caption && @image.caption != ""
      @caption        += "#{@image.source}" if @image.source && @image.source != ""
      @h_caption_title = @image.caption_title
      @h_caption       = @image.caption
      @h_source        = @image.source
    end
    if title && title != ""
      title.strip! 
      @head_line      = eliminate_size_option(title)
      @head_line      = @head_line.gsub(/\u200B/, "")
      # @head_line      = @head_line.gsub("\r\n", "]]></HeadLine><HeadLine><![CDATA[")
      # @head_line      = @head_line.gsub("\r\n", " ")
      # @head_line      = @head_line.gsub("\r", "")
      @head_line      = @head_line.gsub("\n", "")
    end
    if subtitle && subtitle != ""
      subtitle.strip!
      @sub_head_line  = eliminate_size_option(subtitle)
      @sub_head_line  = @sub_head_line.gsub("\r\n", "]]></SubHeadLine><SubHeadLine><![CDATA[")
      # @sub_head_line  = @sub_head_line.gsub("\r", "")
      @sub_head_line  = @sub_head_line.gsub("\n", "]]></SubHeadLine><SubHeadLine><![CDATA[")
    end 
    if boxed_subtitle_text && boxed_subtitle_text != ""
      boxed_subtitle_text.strip!
      @boxed_subtitle = eliminate_size_option(boxed_subtitle_text)
    end

    # h = covert_to_multiple_line(title)
    # puts "++++++ h: #{h}"
    # if h.class == String
    #   @head_line1 = h
    # else
    #   puts "+++++++ title: #{title}"
    #   @head_line1 = h[0]
    #   @head_line2 = h[1]
    # end
    # sh = covert_to_multiple_line(subtitle)
    # if sh.class == String
    #   @sub_head_line1 = subtitle
    # else
    #   @sub_head_line1 = sh[0]
    #   @sub_head_line2 = sh[1]
    #   @sub_head_line3 = sh[2]
    # end
    @photo_item       = "#{@date_id}_#{@jeho_info}_#{@page_info}_#{two_digit_ord}p.jpg"
    @graphic_item       = "#{@date_id}_#{@jeho_info}_#{@page_info}_#{two_digit_ord}g.jpg"
    # images.each do |i|
    #   img = i.image.split(".").first
    #   @photo_item       = "#{img}.jpg"
    # end
    # graphics.each do |g|
    #   grp = g.graphic.split(".").first
    #   @graphic_item       = "#{grp}.jpg"
    # end
    # if story_xml_template.include?("\u200B")
    # end
    @page_number = page_number
    @order = order
    story_erb = ERB.new(story_xml_template)
    story_erb.result(binding)
    # story_erb = ERB.new(story_xml_template)
    # story_erb.result(binding)
  end

  def eliminate_size_option(string) # 제목/부제 사이즈 조절 {-3}같은 태그 제거 
    string = string.sub(/\s?$/, "")
    string = string.sub(/\{\s?(.?\d)\s?\}\s?$/, "") if string =~/\{\s?(.?\d)\s?\}\s?$/
    # string = string.sub(/\{\s?(.?\d)\s?\}\s?$/, "") if string =~/\{\s?(.?\d)\s?\}\s?$/
    string = string.to_s
  end
  

  # def covert_to_multiple_line(string) # 2행만 가능. 3행일 경우 추가 필요
  #   s = string
  #   return "" unless s
  #   if string.include?("\r\n")
  #       s = string.split("\r\n")
  #       return s
  #   end
  #   s
  #  end

  # sample_title = "this a {-5}"
  # result = eliminate_size_option(sample_title)

  # a = "my string"

  def mobile_preview_xml_article_info
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    hour  = updated_at.hour.to_s.rjust(2, "0")
    min   = updated_at.min.to_s.rjust(2, "0")
    sec   = updated_at.sec.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")
    updated_date      = "#{year}#{month}#{day}"
    # if page.section_name = '오피니언'
    #   @news_title_info = '논설'
    # else
    #   @news_title_info  = page.section_name
    # end
    # reporter_record   = Reporter.where(name:reporter).first
    # if reporter_record
    #   @post             = reporter_record.reporter_group.name
    #   @gija_id          = email.split("@").first
    #   @email            = email
    # else
    #   @post             = "소속팀"
    #   @gija_id          = "기자아이디"
    #   @email            = "기자이메일"
    # end
    @name           = reporter
    @by_line        = reporter_from_body
      # if reporter = nil || reporter = ""
      #   @name           = reporter_from_body
      # end
      # if @name =~/_/
      # @name = @name.split("_")[0]
      # end
    opinion_writer  = OpinionWriter.where(name:@name).first
    if opinion_writer
      @work        = opinion_writer.work if opinion_writer.work
      @position    = opinion_writer.position if opinion_writer.position
      @email       = opinion_writer.email if opinion_writer.email
      if @name =~/_/
        @name = @name.split("_")[0]
      elsif @name =~/=/
        @name = @name.split("=")[0]
      elsif @name =~/-/
        @name = @name.split("-")[0]
      end  
      # @by_line_body   = "<br><br>#{@name} #{@work} #{@position}"
      @by_line_body   = "" #20190417 ebiz - 본문 바이라인 삭제요청
      # @by_line        = "#{@name} #{@work} #{@position}"
      @by_line        = "#{@name} #{@work} #{@position}"
      @caption        = "#{@name} #{@work} #{@position}"
    end
    # reporter_record   = Reporter.where(name:reporter).first
    if page_number == 22 && order == 2
      profile         = Profile.where(name:@name).first
      if profile
        @work        = profile.work if profile.work
        @position       = profile.position if profile.position
        if @name =~/_/
          @name = @name.split("_")[0]
        elsif @name =~/=/
          @name = @name.split("=")[0]
        elsif @name =~/-/
          @name = @name.split("-")[0]
        end 
        # @by_line_body   = "<br><br>#{@name} #{@work} #{@position}"
        @by_line_body   = "" #20190417 ebiz - 본문 바이라인 삭제요청
        @by_line        = "#{@name} #{@work} #{@position}"
        # @by_line        = reporter_from_body
        @caption        = "#{@name} #{@work} #{@position}"
      end
    end
    if page_number == 23 && order == 2
      @name          = reporter_from_body
      @by_line_body   = "" #20190417 ebiz - 본문 바이라인 삭제요청
      @by_line       = reporter_from_body
      @caption       = reporter_from_body
    end
    if images.length > 0 
      @image          = images.first
      @caption        = ""
      @caption        = "#{@image.caption_title} | " if @image.caption_title && @image.caption_title != ""
      @caption        += "#{@image.caption} " if @image.caption && @image.caption != ""
      @caption        += "#{@image.source}" if @image.source && @image.source != ""
      @h_caption_title = @image.caption_title
      @h_caption       = @image.caption
      @h_source        = @image.source
      @data_content    = @caption if @image.source && @image.source != ""
    end
    @section_name_code = section_name_code
    if subject_head && subject_head != ""
      subject_head.strip! 
      @name_plate       = eliminate_size_option(subject_head)
    else
    if page_number == 22 || page_number == 23
        @subject_ex_code = opinion_writer.category_code if opinion_writer
        @subject_ex_name = opinion_writer.title if opinion_writer
        @name_plate = opinion_writer.title if opinion_writer
      end
    end    
    # @subject_ex_code  = story.category_code if story && story.category_code && story.category_code != ""
    @subject_ex_code  = category_code if category_code && category_code != ""
    # @subject_ex_name  = @name_plate.gsub(/\[(.*)\]/){"#{$1}"} if @name_plate && @name_plate !="" 
    @subject_ex_name  = find_code_name(story.category_code.to_i) if story && story.category_code && story.category_code != ""
    @money_status     = "30"
    if page_number == 22
      if kind == '사설'
        if subject_head == '기고'
          @subject_ex_code = 2401
          @subject_ex_name = '기고'
          @money_status = "0"
        elsif subject_head == '정치시평'
          @subject_ex_code = 2201
          @subject_ex_name = '정치시평'
        # elsif subject_head == '경제시평'
        #   category_code = 2202
        end
      elsif kind == '기고'
        if subject_head == '신문로'
          @subject_ex_code = 2103
          @subject_ex_name = '신문로'
        elsif subject_head == '경제시평'
          @subject_ex_code = 2202
          @subject_ex_name = '경제시평'
        elsif subject_head == '중국시평'
          @subject_ex_code = 2203
          @subject_ex_name = '중국시평'
        end
        @money_status = "30"
      end
    elsif page_number == 23
      if kind == '사설'
        @subject_ex_code = 2101
        @subject_ex_name = '내일시론'
      end
    end
    @gisa_key         = "#{@date_id}991#{@page_info}#{two_digit_ord}"

    if title && title != ""
      title.strip! 
      @head_line        = eliminate_size_option(title)
      # @head_line        = @head_line.gsub("\r\n", "]]></MainTitle><MainTitle><![CDATA[")
      # @head_line        = @head_line.gsub("\r\n", " ")
      # @head_line        = @head_line.gsub("\r", "")
      @head_line        = @head_line.gsub("\n", "")
      @head_line        = @head_line.gsub("\u2003", "")
    else
      @head_line       = @c_head_line
    end  

    if subtitle && subtitle != ""
      subtitle.strip! 
      @sub_head_line    = eliminate_size_option(subtitle)
      @sub_head_line    = @sub_head_line.gsub("\r\n", "]]></SubTitle><SubTitle><![CDATA[")
      # @sub_head_line    = @sub_head_line.gsub("\r", "")
      @sub_head_line    = @sub_head_line.gsub("\n", "]]></SubTitle><SubTitle><![CDATA[")
      @sub_head_line    = @sub_head_line.gsub("\u2003", "")
    end
    if boxed_subtitle_text && boxed_subtitle_text != ""
      boxed_subtitle_text.strip!
      @boxed_subtitle = eliminate_size_option(boxed_subtitle_text)
    end

    # sh = covert_to_multiple_line(@sub_head_line)
    #   if sh.class == String
    #     @sub_head_line1 = sh
    #   else
    #     @sub_head_line1 = sh[0]
    #     @sub_head_line2 = sh[1]
    #     @sub_head_line3 = sh[2]
    #   end
   if body && body != ""
      @body_content     = body.gsub(/\n\n^\#\#\#\#(.*)/){"<!-- #{$1} -->"}
      @body_content     = @body_content.gsub(/^\#\s(.*)/){"#{$1}"}
      # @body_content     = @body_content.gsub(/^\#\#\#\#(.*)\^\n/){"<!-- #{$1} -->"} 
      @body_content     = @body_content.gsub(/^\#\#\#(.*)/){"<b style=font-weight:bold;>#{$1}</b><br>"} 
      @body_content     = @body_content.gsub(/^\#\#(.*)/){"<b style=font-weight:bold;>#{$1}</b>"} 
      @body_content     = @body_content.gsub(/^\*(.*)=\*/){"<b style=font-weight:bold;>#{$1}</b> = "} 
      @body_content     = @body_content.gsub(/^\*(.*)\*/){"<b style=font-weight:bold;>#{$1}</b> = "} 
      @body_content     = @body_content.gsub(/^\*\*(.*)\*\*/){"<b style=font-weight:bold;>#{$1}</b>"} 
      @body_content     = @body_content.gsub(/\*\*(.*)\*\*/){"<b style=font-weight:bold;>#{$1}</b>"} 
      # @body_content     = @body_content.gsub(/^#\s(.*)/){"#{$1}"} 
      @body_content     = @body_content.gsub(/\^$/){""} 
      @body_content     = @body_content.gsub("\n\n"){"<br><br>"} 
      # @data_content     = @body_content.gsub(/\n\n\z/){""} 
      @data_content     = @body_content.gsub(/<br><br>\z/){""} 

    end
    @page_number = page_number 
    @order = order.to_s.rjust(2, "0")
    @group_key        = "#{year}#{month}#{day}.011001#{page_info}0000#{@order}"
    @cms_file_name    = "#{year}#{month}#{day}00100#{page_info}#{@order}"
    @article_file_name = "#{year}#{month}#{day}011001#{page_info}0000000#{@order}"
    @name        = "편집기자명" # 편집기자명
    @news_class_large_id    = news_class_large_id
    @news_class_large_name  = page.section_name
    # @news_class_middle_id   = category_code
    @news_class_middle_id   = @subject_ex_code
    @news_class_middle_name = @subject_ex_code
    @send_modify            = "0"  # 수정횟수
    @new_article            = "1" #뭘까?
    @photo_file_name        = "#{year}#{month}#{day}.011001#{page_info}0000#{@order}.01L.jpg"
    @graphic_file_name        = "#{year}#{month}#{day}.011001#{page_info}0000#{@order}.02L.jpg"
    #해당기사 저자사진: 121 × 160 픽셀, 120 픽셀/인치
    #해당기사 그래픽은 .01L대신 .01S.jpg로 표시
article_info =<<EOF
    <ArticleInfo>
      <GroupKey><%= @group_key %></GroupKey>
      <CmsFileName><%= @cms_file_name %></CmsFileName>
      <CmsRelationName/>
      <ArticleFileName><%= @article_file_name %>.txt</ArticleFileName>
      <GisaNumberID/>
      <GisaRelationID/>
      <ByLine><%= @by_line %></ByLine> 
      <Gija ID="0" Area="0" Name="<%= @name %>" Email=""/>
      <NewsClass LargeID="<%= @news_class_large_id %>" LargeName="<%= @news_class_large_name %>" MiddleID="<%= @news_class_middle_id %>" MiddleName="<%= @news_class_middle_name %>"/>
      <SendModify><%= @send_modify %></SendModify>
      <NewArticle><%= @new_article %></NewArticle>
    </ArticleInfo>
EOF
    article = ""
    erb = ERB.new(article_info)
    article += erb.result(binding)
  end

  def mobile_preview_xml_three_component
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")
    if page_number == 22
      three_component =<<EOF
      <TitleComponent>
        <MainTitle><![CDATA[[<%= @name_plate %>] <%= @head_line %>]]></MainTitle>
      </TitleComponent>
      <ArticleComponent>
        <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %><%= @by_line_body %>]]></Content>
      </ArticleComponent>
      <PhotoComponent>
      <PhotoItem>
        <ImageType>Image</ImageType>
          <Property ImgClass="[IMG01]" align="left" Class="일반" Size="Large"/>
          <PhotoFileName><%= @photo_file_name %></PhotoFileName>
          <DataContent><![CDATA[ <%= @caption %>]]></DataContent>
        </PhotoItem>
      </PhotoComponent>
    </Article>
EOF

    elsif page_number == 23 && order == 1 
    three_component =<<EOF
    <TitleComponent>
      <MainTitle><![CDATA[[<%= @name_plate %>] <%= @head_line %>]]></MainTitle>
    </TitleComponent>
    <ArticleComponent>
      <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %><%= @by_line_body %>]]></Content>
    </ArticleComponent>
    <PhotoComponent>
    <PhotoItem>
      <ImageType>Image</ImageType>
        <Property ImgClass="[IMG01]" align="left" Class="일반" Size="Large"/>
        <PhotoFileName><%= @photo_file_name %></PhotoFileName>
        <DataContent><![CDATA[ <%= @caption %>]]></DataContent>
      </PhotoItem>
    </PhotoComponent>
  </Article>
EOF
  elsif page_number == 23 && order == 2 
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[[<%= @name_plate %>] <%= @head_line %>]]></MainTitle><% if page_number == 23 && order == 2 %><% else %><% if @sub_head_line == nil && @sub_head_line == "" %><% else %>
    <SubTitle><![CDATA[<%= @sub_head_line %>]]></SubTitle><% end %><% end %>
  </TitleComponent>
  <ArticleComponent>
    <Content><![CDATA[<%= @data_content %>]]></Content>
  </ArticleComponent>
</Article>
EOF

elsif page_number == 23 && order == 3
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[[<%= @name_plate %>] <%= @head_line %>]]></MainTitle>
  </TitleComponent>
  <ArticleComponent>
    <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %><%= @by_line_body %>]]></Content>
  </ArticleComponent>
  <PhotoComponent>
  <PhotoItem>
    <ImageType>Image</ImageType>
      <Property ImgClass="[IMG01]" align="left" Class="일반" Size="Large"/>
      <PhotoFileName><%= @photo_file_name %></PhotoFileName>
      <DataContent><![CDATA[ <%= @caption %>]]></DataContent>
    </PhotoItem>
  </PhotoComponent>
</Article>
EOF

  elsif kind == "사진"
  three_component =<<EOF
  <TitleComponent>
  <MainTitle><![CDATA[<%= @h_caption_title %>]]></MainTitle>
</TitleComponent>
<ArticleComponent>
<Content><![CDATA[<!--[[--image1--]]//--><%= @h_caption %>]]>
</Content>
</ArticleComponent>
<PhotoComponent>
<PhotoItem>
  <ImageType>Image</ImageType>
    <Property ImgClass="[IMG01]" align="left" Class="일반" Size="Large"/>
    <PhotoFileName><%= @photo_file_name %></PhotoFileName>
    <DataContent><![CDATA[ <%= @h_source %>]]></DataContent>
  </PhotoItem>
</PhotoComponent>
</Article>
EOF

elsif kind == "부고-인사"
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[<%= "#{@name_plate}- #{year}#{month}#{day}#{page_info}" %>]]></MainTitle>
  </TitleComponent>
  <ArticleComponent>
    <Content><![CDATA[<%= @data_content %>]]></Content>
  </ArticleComponent>
</Article>
EOF


  elsif images.count > 0 
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[<%= "[#{@name_plate}] " if @name_plate && @name_plate !="" %><%= "| #{@boxed_subtitle} | " if @boxed_subtitle && @boxed_subtitle != "" %><%= @head_line %>]]></MainTitle><% if @sub_head_line == nil && @sub_head_line == "" %><% else %>
    <SubTitle><![CDATA[<%= @sub_head_line %>]]></SubTitle><% end %>
  </TitleComponent><% if images.last.not_related == true %>
  <ArticleComponent>
  <Content><![CDATA[<%= @data_content %>]]></Content>
</ArticleComponent><% else %>
  <ArticleComponent>
    <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %>]]>
    </Content>
  </ArticleComponent>
  <PhotoComponent>
    <PhotoItem>
    <ImageType>Image</ImageType> 
      <Property ImgClass="[IMG01]" align="center" Class="일반" Size="Large"/>
        <PhotoFileName><%= @photo_file_name %></PhotoFileName>
        <DataContent><![CDATA[ <%= @caption %>]]></DataContent>
    </PhotoItem>
  </PhotoComponent><% end %>
</Article>
EOF

  elsif graphics.count > 0 
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[<%= "[#{@name_plate}] " if @name_plate && @name_plate !="" %><%= "| #{@boxed_subtitle} | " if @boxed_subtitle && @boxed_subtitle != "" %><%= @head_line %>]]></MainTitle><% if @sub_head_line == nil && @sub_head_line == "" %><% else %>
    <SubTitle><![CDATA[<%= @sub_head_line %>]]></SubTitle><% end %>
  </TitleComponent>
  <ArticleComponent>
    <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %>]]>
    </Content>
  </ArticleComponent><% if images.length < 0 || graphics.length < 0 %><% else %>
  <PhotoComponent>
    <PhotoItem>
    <ImageType>Image</ImageType> 
      <Property ImgClass="[IMG01]" align="center" Class="일반" Size="Large"/>
        <PhotoFileName><%= @graphic_file_name %></PhotoFileName>
    </PhotoItem>
  </PhotoComponent><% end %>
</Article>
EOF


  else
  three_component =<<EOF
  <TitleComponent>
    <MainTitle><![CDATA[<%= "[#{@name_plate}] " if @name_plate && @name_plate !="" %><%= "| #{@boxed_subtitle} | " if @boxed_subtitle && @boxed_subtitle != "" %><%= @head_line %>]]></MainTitle><% if @sub_head_line == nil && @sub_head_line == "" %><% else %>
    <SubTitle><![CDATA[<%= @sub_head_line %>]]></SubTitle><% end %>
  </TitleComponent>
  <ArticleComponent>
    <Content><![CDATA[<%= @data_content %>]]></Content>
  </ArticleComponent>
</Article>
EOF

  end
  component = ""
  # puts "============ page_number: #{page_number}"
  erb = ERB.new(three_component)
  component += erb.result(binding)
  end

  def xml_group_key_template
    @name_plate       = subject_head
    unless @name_plate
      r = OpinionWriter.where(name:reporter).first
      # puts r
      @subject_ex_code = r.category_code if r && r != ""
      @subject_ex_name = r.title if r && r != ""
      @name_plate = r.title if r && r != ""
    end
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    page_info       = page_number.to_s.rjust(2,"0")
    @head_line      = title
    # if title && title != ""
    #   title.strip!
    #   @head_line        = title    
    #   # @head_line        = @head_line.gsub("\r\n", " ")
    #   @head_line        = @head_line.gsub("\&", "&amp;")
    #   @head_line        = @head_line.gsub("\u201C", "&quot;")
    #   @head_line        = @head_line.gsub("\u201D", "&quot;")
    #   @head_line        = @head_line.gsub("\u0022", "&quot;")
    #   @head_line        = @head_line.gsub("\u003C", "&lt;")
    #   @head_line        = @head_line.gsub("\u003E", "&gt;")
    # end
    @order            = order.to_s.rjust(2, "0")
    @group_key        = "#{year}#{month}#{day}.011001#{page_info}0000#{@order}"
    if title && title != ""    
      if kind == "사진"
        if images.count != 0
        @c_head_line = eliminate_size_option(images.first.caption_title) 
        else 
        @c_head_line = eliminate_size_option(graphics.first.title)
        end
      else
        @c_head_line = eliminate_size_option(@head_line)
      end
      # @c_head_line    = @c_head_line.gsub("\r", "")
      @c_head_line    = @c_head_line.gsub("\n", "")
      # @c_head_line    = @c_head_line.gsub("\&", "&amp;")
    else
      if images.first
      @image          = images.first
      @c_head_line    = @image.caption_title 
      elsif
      @graphic        = graphics.first
      @c_head_line    = @graphic.title
      else
      @c_head_line    = ""
      end 
    end
    container_xml_group_key=<<EOF
      <Group Key="<%= @group_key %>" CmsFileName="" Title="<%= "[#{@name_plate}] " if @name_plate && @name_plate !="" %><%= @c_head_line %>"/>
EOF
    xml_group_key = ""
    erb = ERB.new(container_xml_group_key)
    xml_group_key += erb.result(binding)
  end

  def mobile_page_preview_path
    "#{Rails.root}/public/1/issue/#{issue.date.to_s}/mobile_page_preview/1001#{page_number.to_s.rjust(2,"0")}"
  end

  def save_mobile_xml_image
    source = image_source
    return if source.nil?
    target = mobile_page_preview_path + "/#{@photo_file_name}"
    system("cp #{source} #{target}")
    images.each do |i|
      ext = File.extname(i.image.path)
      image_name = File.basename(i.image.path)
      if ext == ".jpg"
        system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 1200 #{image_name} --out #{mobile_page_preview_path}/#{@photo_file_name}")
      elsif ext == ".pdf"
        system("cd #{issue.path}/images/ && convert -density 300 -resize 1200 #{image_name} #{mobile_page_preview_path}/#{@photo_file_name}")
        # original_pdf = File.open("#{image_name}", 'rb').read
        # image = Magick::Image::from_blob(original_pdf) do
        #   self.format = 'PDF'
        #   self.quality = 100
        #   self.density = 300
        # end
        # image[0].format = 'JPG'
        # image[0].to_blob
        # image[0].write("#{original_pdf}".jpg)
        # system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 1200 #{image_name} --out #{mobile_page_preview_path}/#{@photo_file_name}")
      end
    end
    graphics.each do |g|
      ext = File.extname(g.graphic.path)
      image_name = File.basename(g.graphic.path)
      if ext == ".jpg"
        system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 1200 #{image_name} --out #{mobile_page_preview_path}/#{@graphic_file_name}")
      elsif ext == ".pdf"
        system("cd #{issue.path}/images/ && convert -density 300 -resize 1200 #{image_name} #{mobile_page_preview_path}/#{@graphic_file_name}")
      end
      # elsif ext == ".pdf"
        # original_pdf = File.open("#{image_name}", 'rb').read
        # image = Magick::Image::from_blob(original_pdf) do
        #   self.format = 'PDF'
        #   self.quality = 100
        #   self.density = 300
        # end
        # image[0].format = 'JPG'
        # image[0].to_blob
        # image[0].write("#{original_pdf}".jpg)
        # system("cd #{issue.path}/images/ && sips -s format jpeg -s formatOptions best -Z 1200 #{image_name} --out #{mobile_page_preview_path}/#{@graphic_file_name}")
      # end
    end
  end
end