module PagePrintable
  extend ActiveSupport::Concern

  def page_status
    s = "#{page_number}면"
    if color_page
        s += "(칼라)" 
    else
      s += "(흑백)" 
    end
    s += " 출력: #{print_count}"
    s
  end

  def print_status
    s = ""
    s +=  "인쇄 #{print_time}"   if print_count > 0
    s
  end

  def proof_status
    s = ""
    s +=  "교정 #{proof_time}"   if proof_count > 0
    s
  end

  def print_time
    if latest_printer_file
      File.birthtime(latest_printer_file).to_s.split("+")[0].split(" ")[1]
    end
  end

  def proof_time
    if latest_proof_file
      File.birthtime(latest_proof_file).to_s.split("+")[0].split(" ")[1]
    end
  end

  def printed_files
    Dir.glob("#{printer_folder}/*.pdf").sort
  end

  def proof_files
    Dir.glob("#{proof_folder}/*.pdf").sort
  end


  def printer_file_to_show
    if print_count > 0
      return relative_path + "/printer/#{File.basename(latest_printer_file)}" 
    end
    blank_print_image
  end

  def proof_file_to_show
    if proof_count > 0
      return relative_path + "/proof/#{File.basename(latest_proof_file)}" 
    end
    blank_print_image
  end

  def blank_file_to_show
    if print_count < 0 || proof_count < 0
      return relative_path + "/blank_print_image.jpg" 
    end
  end


  def latest_printer_file
    printed_files.last
  end

  def blank_print_image
    "/1/blank_print_image.jpg"
  end

  def print_count
    printed_files.length
  end

  def proof_count
    proof_files.length
  end

  def proof_path
    path + "/proof"
  end

  def generate_proof_pdf
    FileUtils.mkdir_p(proof_path) unless File.exist?(proof_path)
    r_page_number = page_number.to_s.rjust(2,"0")
    date          = issue.date.day.to_s.rjust(2,"0")
    month         = issue.date.month.to_s.rjust(2,"0")
    year          = issue.date.year.to_s
    proof_files   = Dir.glob("#{proof_path}/#{r_page_number}011001*")
    if proof_files.length == 0
      target_file   = "proof/#{r_page_number}011001-#{date}#{month}#{year}000.pdf"
    else
      curernt_index = proof_files.length
      target_file = "proof/#{r_page_number}011001-#{date}#{month}#{year}000_#{curernt_index}.pdf"
    end
    puts "target_file:#{target_file}"
    system("cd #{path} && cp section.pdf #{target_file}")

    target_file
  end

  def printer_file
    path + "/section.pdf"
  end

  def copy_to_proof_reading_ftp
    require 'net/ftp'
    puts "copying page pdf to proof reading ftp "
    ip  = '211.115.91.231'
    id  = 'naeilcts'
    pw  = 'sodlftlsans1!'
    last_generate_file = generate_proof_pdf
    # upload files
    latest_proof_file = File.new(path + "/#{last_generate_file}")
    Net::FTP.open(ip, id, pw) do |ftp|
      ftp.putbinaryfile(latest_proof_file, "#{File.basename(latest_proof_file)}")
    end
    true
  end
  
  def printer_folder
    path + "/printer"
  end

  def proof_folder
    path + "/proof"
  end

  def latest_printer_file
    Dir.glob("#{printer_folder}/*.pdf").sort.last
  end

  def latest_proof_file
    Dir.glob("#{proof_folder}/*.pdf").sort.last
  end

  def printer_file_version
    File.basename(latest_printer_file).split("_")[1].to_i
  end

  def backup_printer_file
    target_file = printer_folder + "/section_0.pdf"
    FileUtils.mkdir_p(printer_folder) unless File.exist?(printer_folder)
    current_files = Dir.glob("#{printer_folder}/*.pdf")
    if current_files.length > 0
      target_file = printer_folder + "/section_#{current_files.length}.pdf"
    end
    FileUtils.cp(printer_file, target_file)
  end

  def page_color_check
    if page_number == 1
      self.color_page = true
    end 
    self.save
  end

  def copy_to_printer_ftp
    page_color_check
    backup_printer_file
    jung_ang
    dong_a
    news_pdf
    ex_pdf
    copy_to_proof_reading_ftp
    true
  end

  def send_to_expdf_ftp
    news_pdf
    ex_pdf
  end

  def dong_a_code
    date = issue.date
    m = date.month.to_s.rjust(2,"0")
    d = date.day.to_s.rjust(2,"0")
    pg = page_number.to_s.rjust(2,"0")
    if printer_file_version == 0 
      if color_page
        "NA#{m}#{d}#{pg}NC01.pdf"
      else
        "NA#{m}#{d}#{pg}NB01.pdf"
      end
    else
      if color_page
        "NA#{m}#{d}#{pg}NC0#{printer_file_version + 1}.pdf"
      else
        "NA#{m}#{d}#{pg}NB0#{printer_file_version + 1}.pdf"
      end
    end
  end

  def dong_a
    puts "sending it to Dong-A"
    # ip        = ENV['DONG_A_IP']
    # id        = ENV['DONG_A_USER']
    # pw        = ENV['DONG_A_PASSWORD']
    ip        = '210.115.142.181'
    id        = 'naeil'
    # pw        = 'cts@'
    pw        = 'na12'
    Net::FTP.open(ip, id, pw) do |ftp|
      if color_page
        ftp.putbinaryfile(printer_file, "/color/#{dong_a_code}")
      else
        ftp.putbinaryfile(printer_file, "/mono/#{dong_a_code}")
      end
    end
  end

  def jung_ang_code
    date = issue.date
    m = date.month.to_s.rjust(2,"0")
    d = date.day.to_s.rjust(2,"0")
    pg = page_number.to_s.rjust(2,"0")
    if printer_file_version == 0
      "zn#{m}#{d}#{pg}10001.pdf"
     else
      "zn#{m}#{d}#{pg}1000#{printer_file_version + 1}.pdf"
     end
   end

  def jung_ang
    puts "sending it to Jung-Ang"
    # ip        = '112.216.44.45:2121'
    # id        = 'naeil'
    # pw        = 'sodlf@2018'
    # upload files
    printer_file = path + "/section.pdf"
    ftp = Net::FTP.new  # don't pass hostname or it will try open on default port
    # ftp.connect(ENV['JUNGANG_IP'], ENV['JUNGANG_PORT'])  # here you can pass a non-standard port number
    # ftp.login(ENV['JUNGANG_USER'], ENV['JUNGANG_PASSWORD'])
    ftp.connect('112.216.44.45', '2121')  # here you can pass a non-standard port number
    ftp.login('naeil', 'sodlf@2018')
    # ftp.passive = true  # optional, if PASV mode is required
    # Net::FTP.open(ip, id, pw) do |ftp|
    ftp.putbinaryfile(printer_file, "/Naeil/#{jung_ang_code}")
    # end
  end

  def news_pdf_code
    yyyymd = issue.date.strftime("%Y%m%d")
    pg = page_number.to_s.rjust(2,"0")
    "#{yyyymd}-#{pg}.pdf"
  end

  def news_pdf
    puts "sending it to News PDF"
    # ip        = ENV['NEWS_IP']
    # id        = ENV['NEWS_USER']
    # pw        = ENV['NEWS_PASSWORD']
    ip        = '211.115.91.231'
    id        = 'comp'
    pw        = '*4141'
    yyyymd    = issue.date.strftime("%Y%m%d")
    dir_name  = "NewsPDF/#{yyyymd}"
    Net::FTP.open(ip, id, pw) do |ftp|
      # files = ftp.list
      # ftp.mkdir(dir_name) unless ftp.list("/").any?{|dir| dir.match(/\s#{dir_name}$/)}
      # ftp.mkdir dir_name unless File.exists?(dir_name)
      ftp.putbinaryfile(printer_file, "#{dir_name}/#{news_pdf_code}")
    end
  end

  def ex_pdf_code
    jeho = issue.number
    yymd = issue.date.strftime("%y%m%d")
    pg = page_number.to_s.rjust(2,"0")
    "#{jeho}-#{yymd}#{pg}.pdf"
  end

  def ex_pdf
    puts "sending it to External PDF"
    # ip        = ENV['NEWS_IP']
    # id        = ENV['NEWS_USER']
    # pw        = ENV['NEWS_PASSWORD']
    ip        = '211.115.91.231'
    id        = 'comp'
    pw        = '*4141'
    yyyymd    = issue.date.strftime("%Y%m%d")
    dir_name  = "외부전송PDF"
    Net::FTP.open(ip, id, pw) do |ftp|
      # ftp.mkdir dir_name unless File.exists?(dir_name)
      ftp.putbinaryfile(printer_file, "#{dir_name}/#{ex_pdf_code}")
    end
  end


  def dropbox_path
    File.expand_path("~/dropbox")
  end

  def dropbox_page_path
    dropbox_path + "/#{date}_#{page_number}.pdf"
  end

  def dropbox_exist?
    File.exist?(dropbox_path)
  end

  def copy_to_drop_box
    unless dropbox_exist?
      return "드롭박스가 설치되지 않았습니다."
    else
      system("cp #{pdf_path} #{dropbox_page_path}")
      return true
    end
  end


end
