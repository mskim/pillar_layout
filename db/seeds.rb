require 'csv'
require 'yaml'

page_layout_csv_path = "#{Rails.root}/public/page_layout.csv"
csv_text = File.read(page_layout_csv_path)
csv = CSV.parse(csv_text)
keys  = csv.shift
keys.map!{|e| e.to_sym}
csv.each do |row|
  row[2] = eval(row[2])
  row_h = Hash[keys.zip row]
  s = PageLayout.where(row_h).first_or_create!
end

  # add actions to db
  action_yml_path = "#{Rails.root}/public/action.yml"
  action_hash = YAML.load_file(action_yml_path)
  action_hash.each do |k, v|
    h = { name: k, actions: v }
    Action.where(h).first_or_create!
  end
  # box with no actions
  # (1..7).to_a.each do |column|
  #   (6..15).to_a.each do |row|
  #     LayoutNode.where(column: column, row: row).first_or_create
  #   end
  # end

  # get the size that were used in PageLayout only
  PageLayout.all.each do |pl|
    pl.pillars.each do |pillar|
      LayoutNode.where(column: pillar.column, row: pillar.row).first_or_create
    end
  end

  # box with actions
  LayoutNode.all.each do |node|
    Action.all.each do |a|
      node = LayoutNode.where(column: node.column, row: node.row).create
      puts "+++++#{node.column}x#{node.row}"
      puts "++++++a.actions:#{a.actions}"
      node.set_actions(a.actions)
    end
  end


section_names = [
  '1면',
  '정치',
  '정치',
  '정치',
  '자치행정',
  '자치행정',
  '전면광고',
  '국제통일',
  '금융',
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

Category.parse


h = {}
h[:id]                              = 1
h[:name]                            = '내일신문'
p = Publication.where(h).first_or_create
h[:paper_size]                      = '신문대판'
h[:unit]                            = 'mm'
h[:width_in_unit]                   = 393  # 1114.02 pt
h[:height_in_unit]                  = 545  # 1544.88 pt
h[:left_margin_in_unit]             = 15   # 42.52
h[:top_margin_in_unit]              = 15   # 56.69292
h[:right_margin_in_unit]            = 15   # 42.52
h[:bottom_margin_in_unit]           = 15   # 42.52
h[:gutter_in_unit]                  = 4.5  # 12.75
h[:lines_per_grid]                  = 7
h[:page_count]                      = 24
h[:section_names]                   = section_names
h[:page_columns]                    = [6,7]
h[:row]                             = 15
h[:front_page_heading_height]       = 10
h[:inner_page_heading_height]       = 3
h[:article_bottom_spaces_in_lines]  = 2
h[:article_line_draw_sides]         = [0,0,0,1]
h[:article_line_thickness]          = 0.3
h[:cms_server_url]                  = 'http:://localhost:3001'
p.update(h)
p.copy_text_style_to_shared_location

issue_date = Date.new(2017,5,30)
# create ad_bookins for 5 days
ad_date = issue_date
5.times do
  AdBooking.where(publication: p, date: ad_date).first_or_create
  ad_date = ad_date + 1.days
end
section_names.each_with_index do |section_name, i|
  SectionHeading.where(publication_id:p.id, page_number: i + 1, section_name: section_name, date: Date.new(2017,5,30)).first_or_create
end

current_style_path =  "/Users/Shared/SoftwareLab/newsman/#{p.name}/text_style.yml"
styles = YAML::load_file(current_style_path)
styles.each do |k,v|
  value = v.dup
  value[:english] = k
  h = Hash[value.map{ |key, value| [key.to_sym, value] }]
  h[:graphic_attributes] = h[:graphic_attributes].to_s
  TextStyle.where(h).first_or_create
end

ad_csv_path = "#{Rails.root}/public/1/ad/ads.csv"
csv_text = File.read(ad_csv_path)
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Ad.where(row.to_hash).first_or_create
end

reporter_group_csv_path = "#{Rails.root}/public/1/reporter/reporter_groups.csv"
csv_text = File.read(reporter_group_csv_path)
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  ReporterGroup.where(row.to_hash).first_or_create
end

reporter_csv_path = "#{Rails.root}/public/1/reporter/reporters.csv"
csv_text = File.read(reporter_csv_path)
csv = CSV.parse(csv_text, :headers => true)
current_section = ''
csv.each do |row|
  h = row.to_hash
  h = Hash[h.map{ |key, value| [key.to_sym, value] }]
  section = h.delete(:section)
  if section && section != current_section
    current_section = section
  end
  g = ReporterGroup.where(section: current_section).first
  if g
    h[:group]     = g.section
  end
  h[:role]                  = 0
  h[:password]              = "itis" + h[:cell].split("-").last
  h[:password_confirmation] = h[:password]
  User.create!(h) unless User.where(email: h[:email]).first
end

opinion_writer_csv_path = "#{Rails.root}/public/1/opinion/data.csv"
csv_text = File.read(opinion_writer_csv_path)
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  h = row.to_hash
  h = Hash[h.map{ |key, value| [key.to_sym, value] }]
  h[:publication_id] = 1
  OpinionWriter.where(h).first_or_create
end

profile_csv_path = "#{Rails.root}/public/1/profile/data.csv"
csv_text = File.read(profile_csv_path)
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  h = row.to_hash
  h = Hash[h.map{ |key, value| [key.to_sym, value] }]
  h[:publication_id] = 1
  Profile.where(h).first_or_create
end


SECTIONS = [
  '1면',
  '정치',
  '자치행정',
  '국제통일',
  '금융',
  '산업',
  '정책',
  '기획',
  '오피니언',
]


User.create!(name: "김민수", email: "mskimsid@gmail.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "장원호", email: "twinger0885@gmail.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "김형규", email: "hgkim@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "양유미", email: "biny@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "안상현", email: "shahn@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'designer')
User.create!(name: "한승효", email: "shhan@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'designer')
User.create!(name: "반수희", email: "shban@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'designer')
User.create!(name: "지선미", email: "smjee@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'designer')
User.create!(name: "이동명", email: "leedongmyeong@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "다니엘", email: "daniel@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 'admin')
User.create!(name: "안찬수", email: "khaein@naeil.com", password: 'itis0897', password_confirmation: "itis0897", role: 'chief_editor')
User.create!(name: "김영서", email: "yskim@naeil.com", password: 'itis4141', password_confirmation: "itis4141", role: 'marketing')
User.create!(name: "권상진", email: "sjkwon@naeil.com", password: 'itis4141', password_confirmation: "itis4141", role: 'marketing')
User.create!(name: "서상우", email: "swseo@naeil.com", password: 'itis4440', password_confirmation: "itis4440", role: 'marketing')

User.create!(name: "김정치", email: "k_2@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정치', role: 'reporter')
User.create!(name: "김행정", email: "k_3@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '자치행정', role: 'reporter')
User.create!(name: "김국제", email: "k_4@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '국제통일', role: 'reporter')
User.create!(name: "김금융", email: "k_5@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '금융', role: 'reporter')
User.create!(name: "김산업", email: "k_6@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '산업', role: 'reporter')
User.create!(name: "김정책", email: "k_7@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정책', role: 'reporter')
User.create!(name: "김기획", email: "k_8@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '기획', role: 'reporter')
User.create!(name: "김오피", email: "k_9@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '오피니언', role: 'reporter')

User.create!(name: "이정치", email: "l_2@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정치', role: 'reporter')
User.create!(name: "이행정", email: "l_3@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '자치행정', role: 'reporter')
User.create!(name: "이국제", email: "l_4@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '국제통일', role: 'reporter')
User.create!(name: "이금융", email: "l_5@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '금융', role: 'reporter')
User.create!(name: "이산업", email: "l_6@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '산업', role: 'reporter')
User.create!(name: "이정책", email: "l_7@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정책', role: 'reporter')
User.create!(name: "이기획", email: "l_8@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '기획', role: 'reporter')
User.create!(name: "이오피", email: "l_9@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '오피니언', role: 'reporter')

User.create!(name: "양정치", email: "y_2@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정치', role: 'reporter')
User.create!(name: "양행정", email: "y_3@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '자치행정', role: 'reporter')
User.create!(name: "양국제", email: "y_4@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '국제통일', role: 'reporter')
User.create!(name: "양금융", email: "y_5@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '금융', role: 'reporter')
User.create!(name: "양산업", email: "y_6@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '산업', role: 'reporter')
User.create!(name: "양정책", email: "y_7@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정책', role: 'reporter')
User.create!(name: "양기획", email: "y_8@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '기획', role: 'reporter')
User.create!(name: "양오피", email: "y_9@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '오피니언', role: 'reporter')

User.create!(name: "한정치", email: "h_2@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정치', role: 'reporter')
User.create!(name: "한행정", email: "h_3@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '자치행정', role: 'reporter')
User.create!(name: "한국제", email: "h_4@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '국제통일', role: 'reporter')
User.create!(name: "한금융", email: "h_5@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '금융', role: 'reporter')
User.create!(name: "한산업", email: "h_6@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '산업', role: 'reporter')
User.create!(name: "한정책", email: "h_7@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정책', role: 'reporter')
User.create!(name: "한기획", email: "h_8@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '기획', role: 'reporter')
User.create!(name: "한오피", email: "h_9@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '오피니언', role: 'reporter')

User.create!(name: "안정치", email: "a_2@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정치', role: 'reporter')
User.create!(name: "안행정", email: "a_3@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '자치행정', role: 'reporter')
User.create!(name: "안국제", email: "a_4@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '국제통일', role: 'reporter')
User.create!(name: "안금융", email: "a_5@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '금융', role: 'reporter')
User.create!(name: "안산업", email: "a_6@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '산업', role: 'reporter')
User.create!(name: "안정책", email: "a_7@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '정책', role: 'reporter')
User.create!(name: "안기획", email: "a_8@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '기획', role: 'reporter')
User.create!(name: "안오피", email: "a_9@gmail.com", password: 'itis1234', password_confirmation: "itis1234", group: '오피니언', role: 'reporter')

# title = "기사 제목은 여기에..."
# body  = "여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다."
# ReporterGroup.all.each do |group|
#   users = User.where(group: group.section).all
#   10.times do |i|
#     user = users[i]
#     Story.where(date: issue.date, user: user, group: user.group, title: title, body: body).first_or_create if user
#   end
# end


base = "여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다. 여기는 본문입니다.\n\n"
User.all.each do |user|
  2.times do |i|
    next unless user.role == 'reporter'
    date = Date.today
    title     = "여기는 #{user.name}의 제목 입니다."
    subtitle  = "여기는 #{user.name}의 부제목 입니다."
    status = true if i == 2
    random_num = (15..30).to_a.sample
    body = base*random_num
    Story.where(date: date, user: user, group: user.group, title: title, subtitle: subtitle, body: body, summitted: status).first_or_create if user.group
  end
end

combo_ad_csv_path = "#{Rails.root}/public/1/combo_ad/combo_ad.csv"
csv_text          = File.read(combo_ad_csv_path)
csv               = CSV.parse(csv_text)
keys              = csv.shift
keys.map!{|e| e.to_sym}
csv.each do |row|
  row_h = Hash[keys.zip row]
  ca    = ComboAd.where(row_h).first_or_create!
end

# load sample YTN articles and images
# YNewsML.load_ytn_sample


issue = Issue.where(id: 1, date: issue_date , number: '00001', publication_id: 1).first_or_create
if issue
  issue.make_default_issue_plan 
  issue.make_pages
  issue.pages.all.each{|p| p.generate_pdf_with_time_stamp}
end