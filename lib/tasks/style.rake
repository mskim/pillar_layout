namespace :style do
  require 'csv'
  

  desc 'generate issue pdf'
  task :pdf_all =>:environment do
    WorkingArticle.all.each do |w|
      w.generate_pdf_with_time_stamp(no_page_pdf:true)
    end
    Page.all.each do |p|
      p.generate_pdf_with_time_stamp
    end
  end


  desc 'convert section.csv pillar.csv'
  task :section2pillar =>:environment do
    csv_path = "#{Rails.root}/public/1/section/sections.csv"
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text)
    keys  = csv.shift
    pillar_string = %w[page_type column layout].to_csv
    pillars = []
    csv.each do |row|
      pillar_row = Section.section2pillar(row).to_csv
      pillar_row.gsub!("\"\"", "\'")
      pillar_string += pillar_row
    end
    pillar_path = "#{Rails.root}/public/1/section/pillar.csv"
    File.open(pillar_path, 'w'){|f| f.write pillar_string}
  end

  def siblings(article)
    grid_x          = article.grid_x
    grid_right_edge = article.grid_x + article.column
    grid_bottom     = article.grid_y + article.row
    siblings_array = working_articles.select do |wa|
      wa_right_edge = wa.grid_x + wa.column
      wa.grid_y == grid_bottom && wa.grid_x >= grid_x && wa_right_edge <= grid_right_edge  && wa != article
    end
    # siblings_array += image_boxes.select do |image_box|
    #   image_box.grid_y == grid_bottom && wa.grid_x >= grid_x && wa != article
    # end
  end


  desc 'import section csv file'
  task :import_section_csv =>:environment do
    csv_path = "#{Rails.root}/public/1/section/sections.csv"
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text)
    keys  = csv.shift
    keys.map!{|e| e.to_sym}
    csv.each do |row|
      row_h = Hash[keys.zip row]
      # row_h.delete(:divider_position)
      # puts "row_h:#{row_h}"
      row_h[:publication] = 1
      s = Section.where(row_h).first_or_create!
      s.create_articles if s
      # if s.page_number == 22 || s.page_number == 23
      #   # puts "s.id:#{s.id}"
      #   # puts "s.layout:#{s.layout}"
      #   s.regerate_section_preview
      # end
    end
  end  

  desc 'prints hi wonho'
  task :hi_wonho do
    puts "Hi wonho!!!!!"
  end

  desc 'import opinion csv file'
  task :import_opinion_csv =>:environment do
    opinion_writer_csv_path = "#{Rails.root}/public/1/opinion/data.csv"
      csv_text = File.read(opinion_writer_csv_path)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      h = row.to_hash
      h = Hash[h.map{ |key, value| [key.to_sym, value] }]
      h[:publication_id] = 1
      OpinionWriter.where(h).first_or_create
    end
  end  


  desc 'make nil setion ad_type as empty string'
  task :change_nil_ad_type =>:environment do
    Section.all.each do |section|
      if section.ad_type.nil?
        section.ad_type = ""
        section.save
      end
    end
  end

  desc 'seed stories'
  task :seed_stories =>:environment do
    ReporterGroup.all.each do |group|
    users = User.where(group: group.section).all
      10.times do |i|
        user = users[i]
        date = Issue.last.date
        Story.where(date: issue.date, user: user, group: group).first_or_create if user
      end
    end
  end

  desc 'scrape form gw'
  task :scrape_gw =>:environment do
    Issue.scrape_gw
  end

  desc 'parse gw'
  task :parse_gw =>:environment do
    Issue.parse_gw
  end

  desc 'set all pages as color page except 22, 23'
  task :set_color_page  =>:environment do
    puts "running set_color_page..."
    Issue.last.pages.each do |page|
      puts page.page_number
      if page.page_number == 22 || page.page_number == 23
        page.color_page = false
      else
        page.color_page = true
      end
      page.save
    end
  end

  desc 'create new issue'
  task :new_issue =>:environment do
    today = Date.today
    if Publication.holidays.include? Date.today.to_s
      puts "#{today.to_s} is holiday."
    elsif today.sunday? || today.saturday?
      puts "#{today.to_s} is weekend."
    else
      puts "today is working day."
      if Issue.where(date:today).first
        puts "#{today.to_s}'s issue is already created!!!'"
      else
        prev_issue = Issue.last
        prev_issue_number = prev_issue.number.to_i || 1
        puts issue_number= prev_issue_number + 1
        i = Issue.new(publication_id:Publication.first.id, date:today, number: issue_number)
        i.prepare
        i.save
        i.make_default_issue_plan
        i.make_pages
        i.set_color_page
        puts "created new issue at #{Time.now} ..."
      end
    end

  end

  desc 'copy text_style to users'
  task :copy_text_style_to_shared =>:environment do
    text_style_yml_path = "#{Rails.root}/public/1/text_style/text_style.yml"
    target_folder = "/Users/Shared/SoftwareLab/newsman/내일신문"
    system "cp #{text_style_yml_path} #{target_folder}/"
  end

  desc "update page_heding"
  task :update_page_heading =>:environment do
    Page.all.each do |page|
      page.copy_heading
    end
  end

  desc "create page_headings for all section"
  task :create_page_headings =>:environment do
    puts "creating page_headings ..."
      section_names = [
        '1면',
        '정치',
        '정치',
        '정치',
        '자치행정',
        '자치행정',
        '전면광고',
        '국제통일',
        '전면광고',
        '금융',
        '전면광고',
        '금융',
        '금융',
        '산업',
        '산업',
        '산업',
        '산업',
        '정책',
        '정책',
        '기획',
        '기획',
        '오피니언',
        '오피니언',
        '전면광고'
      ]


    section_names.each_with_index do |section_name, i|
      PageHeading.where(publication_id: 1, page_number: i + 1, section_name: section_name, date: Date.new(2017,5,30)).first_or_create
    end
  end

  desc "copy all artifcle outputs to site locaton"
  task :copy_articles_to_site =>:environment do
    WorkingArticle.all.each do |article|
      article.copy_outputs_to_site
    end
  end

  desc "copy all page outputs to site locaton"
  task :copy_pages_to_site =>:environment do
    Page.all.each do |article|
      article.copy_outputs_to_site
    end
  end


  desc "generating pdf for all articles"
  task :generate_pdf =>:environment do
    puts "generating pdf for all articles"
    Article.all.each do |article|
      article.create_folders
      article.generate_pdf
    end
  end


  desc "generating pdf for all articles"
  task :generate_page_pdf =>:environment do
    puts "generating pdf for all articles"
    Page.all.each do |page|
      page.generate_pdf
    end
  end

  desc "generating pdf for all articles unless it exist"
  task :update_pdf_unless =>:environment do
    puts "generating pdf for all articles unless"
    Article.all.each do |article|
      article.create_folders
      article.update_pdf_unless
    end
  end

  desc "update pdf for all articles"
  task :update_pdf =>:environment do
    puts "update pdf for all articles"
    Article.all.each do |article|
      article.update_pdf
    end
  end

  desc "save all articles"
  task :save_article =>:environment do
    puts "save articles"
    Article.all.each do |article|
      article.save_article
    end
  end

  desc "generating pdf for all ads"
  task :generate_ad_pdf =>:environment do
    puts "generating pdf for all ads"
    Ad.all.each do |ad|
      ad.generate_pdf
    end
  end

  desc "update section config yml for all sections"
  task :save_section_config_yml =>:environment do
    puts "saved section config yml for all sections"
    Section.all.each do |section|
      section.save_section_config_yml
    end
  end

  desc "update section profile for all sections"
  task :update_section_profile =>:environment do
    puts "update section layout for all sections"
    Section.all.each do |section|
      section.make_profile
      section.save
    end
  end

  desc "update section layout for all sections"
  task :update_section_layout =>:environment do
    puts "update section layout for all sections"
    Section.all.each do |section|
      section.generate_ad_box_template_pdf
      section.update_section_layout
    end
  end

  desc "update section layout for all sections if it is not have layout"
  task :update_section_layout_if =>:environment do
    puts "update section layout for all sections"
    Section.all.each do |section|
      section.update_section_layout_if
    end
  end

  desc "generating pdf for all sections"
  task :generate_section_pdf =>:environment do
    puts "generating pdf for all sections"
    Section.all.each do |section|
      section.generate_pdf
    end
  end

  desc "delete generated pdf ad for all section"
  task :delete_pdf_ad =>:environment do
    puts "delete generated pdf ad for all section"
    Section.all.each do |section|
      section.delete_pdf_ad
    end
  end


  desc "parse section scv file"
  task :parse_section_csv =>:environment do
    csv_path = "#{Rails.root}/public/1/section/sections.csv"
    csv_text = File.read(csv_path)
    # csv = CSV.parse(csv_text, :headers => true)
    csv = CSV.parse(csv_text)
    keys  = csv.shift
    keys.map!{|e| e.to_sym}
    column_index          = keys.index('column')
    row_index             = keys.index('row')
    page_number_index     = keys.index('page_number')
    section_name_index    = keys.index('section_name')
    layout_index          = keys.index('layout')

    csv.each do |row|
      row_h = Hash[keys.zip row]
      row_h.delete(:profile)
      # Member.create!(row.to_hash)
      Section.where(row_h).first_or_create
    end
  end

  desc "generating heading pdf for all sections "
  task :generate_section_heading_pdf =>:environment do
    puts "generating pdf for all page headings"
    Section.all.each do |section|
      section.generate_heading_pdf
    end
  end

  desc "generating heading pdf for all pages"
  task :generate_page_heading_pdf =>:environment do
    Page.all.each do |page|
      puts "page.page_number:#{page.page_number}"
      page.generate_heading_pdf
    end
  end

  desc "update heading pdf for all pages"
  task  :update_page_heading_pdf=>:environment do
    Page.all.each_with_index do |page, i|
      next if i == 0
      puts "page.page_number:#{page.page_number}"
      PageHeading.generate_pdf(page)
    end
  end

  desc 'create issue plan'
  task :create_issue_plan =>:environment do
    puts "creating a issue"
    issue_content = "issue_plan = [\n"

    24.times do |i|
      page = i+1
      # puts "page:#{page}"
      page_hash = {page_number: page}
      section = Section.where(page_hash).sample
      section_hash = section.attributes
      section_hash = Hash[section_hash.map{ |k, v| [k.to_sym, v] }]
      section_hash[:page_number] = page
      section_hash.delete(:id)
      section_hash.delete(:section_name)
      section_hash.delete(:is_front_page)
      section_hash.delete(:order)
      section_hash.delete(:ad_type) unless section_hash[:ad_type]
      section_hash.delete(:layout)
      section_hash.delete(:publication_id)
      section_hash.delete(:created_at)
      section_hash.delete(:updated_at)
      page_hash.merge!(section_hash)
      issue_content += "  " + page_hash.to_s + ",\n"
    end
    issue_content += "\n]"
    issue_path = "#{Rails.root}/public/1/issue/default_issue_plan.rb"
    File.open(issue_path, 'w'){|f| f.write issue_content}
  end

  desc "show all page's working_articles count"
  task :working_articles_count =>:environment do
    puts "show all page's working_articles count"
    Page.all.each do |page|
      puts "+++++"
      puts "page.page_number:#{page.page_number}"
      puts "page.story_count:#{page.story_count}"
      puts "page.working_articles.length:#{page.working_articles.length}"
    end
  end

  desc "show all working_articles order"
  task :working_articles_order =>:environment do
    puts "show all page's working_articles count"
    WorkingArticle.all.each do |article|
      puts "+++++"
      puts "article.page_id:#{article.page_id}"
      puts "article.order:#{article.order}"
    end
  end

  desc "generate text styles pdf"
  task :generate_text_style_pdf =>:environment do
    puts "generating pdf for all text_styles"
    TextStyle.all.each do |style|
      style.generate_pdf
    end
  end

  desc "update text styles csv"
  task :update_text_styles_csv =>:environment do
    csv_path = "#{Rails.root}/public/1/text_styles/text_styles.csv"
    csv_text = File.read(csv_path)
    # csv = CSV.parse(csv_text, :headers => true)
    csv      = CSV.parse(csv_text)
    keys     = csv.shift
    keys.map!{|e| e.to_sym}
    csv.each do |row|
      row_h = Hash[keys.zip row]
      selecting_h = {}
      selecting_h[:name] = row_h[:name]
      selecting_h[:publication_id] = row_h[:publication_id]
      style = TextStyle.where(selecting_h).first_or_create
      style.update(row_h)
    end
  end

  desc "convert text styles csv"
  task :convert_text_styles_csv =>:environment do
    text_styles_csv_path = "#{Rails.root}/public/1/text_style/text_styles.csv"
    text_styles_list_path = "#{Rails.root}/public/1/text_style/text_styles_list.rb"
    text_styles_named_key_path = "#{Rails.root}/public/1/text_style/text_styles_named_key.rb"
    text_styles_csv_path = "#{Rails.root}/public/1/text_style/text_styles.csv"
    csv_text = File.read(text_styles_csv_path)
    csv      = CSV.parse(csv_text)
    keys     = csv.shift
    keys.map!{|e| e.to_sym}
    text_styles_list = []
    text_styles_named_hash = {}
    csv.each do |row|
      float_row = row.map do |f|
        if f =~/^\d/ || f=~/^-/
          f.to_f
        else
          f
        end
      end
      row_h = Hash[keys.zip float_row]
      text_styles_list << row_h.dup
      name = row_h[:name].to_s
      without_name = row_h.delete(:name)
      text_styles_named_hash[name] = row_h
    end

    File.open(text_styles_list_path, 'w'){|f| f.write text_styles_list.to_s}
    File.open(text_styles_named_key_path, 'w'){|f| f.write text_styles_named_hash.to_s}

  end



end
