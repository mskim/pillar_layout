require 'csv'
require 'yaml'
section_names = [
  '1면',
  '2면',
  '3면',
  '4면',
]

h = {}
h[:name]                            = '죽전우리교회'
h[:paper_size]                      = 'A4'
h[:unit]                            = 'mm'
h[:width_in_unit]                   = 393  # 1114.02 pt
h[:height_in_unit]                  = 545  # 1544.88 pt
h[:left_margin_in_unit]             = 15   # 42.52
h[:top_margin_in_unit]              = 20   # 56.69292
h[:right_margin_in_unit]            = 15   # 42.52
h[:bottom_margin_in_unit]           = 15   # 42.52
h[:gutter_in_unit]                  = 4.5  # 12.75
h[:lines_per_grid]                  = 7
h[:page_count]                      = 24
h[:section_names]                   = section_names
h[:page_columns]                    = 6
h[:row]                             = 6
h[:front_page_heading_height]       = 3
h[:inner_page_heading_height]       = 0
h[:article_bottom_spaces_in_lines]  = 0
h[:article_line_draw_sides]         = [0,0,0,0]
h[:article_line_thickness]          = 0.3

p = Publication.where(h).first_or_create
p.copy_text_style_to_shared_location

section_names.each_with_index do |section_name, i|
  SectionHeading.where(publication_id:p.id, page_number: i + 1, section_name: section_name, date: Date.new(2017,5,30)).first_or_create
end

current_style_path =  "/Users/Shared/SoftwareLab/newsman/#{p.name}/text_style.yml"
styles = YAML::load_file(current_style_path)
styles.each do |k,v|
  value = v.dup
  value[:english] = k
  h = Hash[value.map{ |key, value| [key.to_sym, value] }]
  TextStyle.where(h).first_or_create
end

csv_path = "#{Rails.root}/public/1/section/sections.csv"
csv_text = File.read(csv_path)
csv = CSV.parse(csv_text)
keys  = csv.shift
keys.map!{|e| e.to_sym}
csv.each do |row|
  row_h = Hash[keys.zip row]
  # row_h.delete(:divider_position)
  s = Section.where(row_h).first_or_create!
  s.create_articles if s
  if s.page_number == 22 || s.page_number == 23
    # puts "s.id:#{s.id}"
    # puts "s.layout:#{s.layout}"
    s.regerate_section_preview
  end
end

SECTIONS = [
  '1면',
  '2면',
  '3면',
  '4면',
]

issue = Issue.where(id: 1, date: Date.new(2017,5,30), number: '00001', publication_id: 1).first_or_create
issue.make_default_issue_plan if issue

User.create!(name: "김민수", email: "mskimsid@gmail.com", password: 'itis1234', password_confirmation: "itis1234", role: 3, publication_id: 1)
User.create!(name: "김지윤", email: "hgkim@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 3, publication_id: 1)
User.create!(name: "편집1", email: "editor1@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 1, publication_id: 1)
User.create!(name: "편집2", email: "editor2@naeil.com", password: 'itis1234', password_confirmation: "itis1234", role: 1, publication_id: 1)
User.create!(name: "기자1", email: "reporter1@naeil.com", password: 'itis1234', password_confirmation: "itis1234", publication_id: 1)
User.create!(name: "기자2", email: "reporter2@naeil.com", password: 'itis1234', password_confirmation: "itis1234", , publication_id: 1)
