# PillarLayout

Rails app for creating style guide for newspaper publication

## Tables

### reporter_image

### reporter_graphic
  - user_id        :bigint(8)
  - title          :string
  - caption        :string
  - source         :string
  - wire_pictures  :string
  - section_name   :string
  - used_in_layout :boolean
  - has_many_attached :uploads
  - has_one_attached :finished_job 

### expert_writer
  - name              :string
  - work              :string
  - position          :string
  - email             :string
  - expert_image     :string
  - expert_jpg_image  :string

### AdBooking
  publication:references
  date:date
  ad_item:text
  has_many :ad_plans

### AdPlan
  AdBooking:references
  Issue:references
  page:integer
  ad_type
  advertiser
  color:boolean

### spread
  issue: references
  left_page
  right_page
  has_many :ad_boxes
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  page_gutter

### spread_ad_box
  t.string :ad_type
  t.integer :row
  t.integer :width
  t.integer :height
  t.string :advertiser
  t.references :spread, foreign_key: true

### publication
  name
  paper_size
  width
  height
  left_margin
  top_margin
  right_margin
  bottom_margin
  lines_per_grid
  page_gutter
  gutter
  page_count
  section_names
  page_columns

### ad
  name
  korean_name
  page_columns
  column
  row


### text_style
  reference
  name
  korean_name
  font
  size
  text_color
  tracking
  space_width
  scale
  space_before_in_lines
  text_height_in_lines
  space_after_in_lines

### article

  column
  row
  title
  subtitle
  body
  reporter
  has_profile_image
  image
  quote

## section_heading
page_number
publication_id
section_name
date

## page_heading
  page_id
  page_number
  section_name
  layout
  publication

## heading_ad_images
  x
  y
  width
  height
  x_in_unit
  y_in_unit
  width_in_unit
  height_in_unit
  ad_image # carrierwave uploader
  advertiser
  page_heading_id

## issue
  references:publication
  issue_number:integer
  date: date

## page
  page_number
  section_name
  ad_type
  story_count
  column
  row
  is_front_page
  profile
  color_page

  issue_id
  template_id

## working_article
  t.integer :column
  t.integer :row
  t.integer :order
  t.integer :profile
  t.string :title
  t.string :subtitle
  t.text :body
  t.string :reporter
  t.string :email
  t.string :has_profile_image
  t.string :image
  t.string :quote
  t.string :subject_head
  t.boolean :is_front_page
  t.boolean :top_story
  t.boolean :top_position
  t.string :kind
  t.integer :page_columns
  t.references :issue, foreign_key: true

## AdBox
  t.integer :column
  t.integer :row
  t.string :ad_type
  t.string :advertiser
  t.references :page, foreign_key: true

## AdImage


## Issue_plan_page
  page_number
  ad_kind
  story_count
  page_columns
  color_page
  section_name
  issue:references

## ReporterGroup
  section
  team_leader
  page_range

## Reporters
  name
  email
  reporter_group:references
  title

## article_plan

  page_plan_id
  reporter
  order

## holidays
  day
  name


## editable_ad
  advertiser
  phone
  kind
  grid_x
  grid_y
  column
  row
  order
  page:references
  title
  subtitle
  body
  copy1
  box_ad_image
  price:float
  date:date

## table
  column:
  row:
  extended_line_count:
  body:text
  title:string
  source:string
  working_article:references
  table_style_id:integer
  

## table_style
  - name
  - heading_level:integer
  - category_level:integer
  - has_source:boolean
  - heading:text
      - sides
      - font
      - font_size
      - alignment
      
  - body:text
  - category_level:
  - category_colors:text
  - cycle_color:boolean
  - cycle_color_list:text


TO: publication_name@naeil.design
subject: 3x4

---
title: title of Article
subtitle: subtitle of Article
___

body text goes here.
## AdPage
  - date
  - page_number
  - paper_size
## BoxAd
  - advertizer
  - email
  - size
  - category
  - title
  - subtitle
  - picture
  - price
  - starting:date
  - ending:date

## annotation
    workiong_article:references
    version:integer

## annotation_comment
    annotation:references
    user:references
    x,y,width,height, integer
    comment:text
    color
    shape: #rect, check, circle, delete_mark, underline, 

## static_video

## static_qrcode

## static_toc
title
toc_text:text
position:interger # 1..9


## story
image_info : text
image_info : text
page_number :integer
pillar_order




## article_kinds
  t.string :name
  t.text :line_draw_sides
  t.text :input_fields
  t.integer :bottoms_space_in_lines
  t.text :layout_erb
## page_heading_kinds

  t.refernces :publication
  t.string :page_type
  t.text :layout_erb
  t.integer :height_in_lines
  t.string :bg_image


## PrepArticle
  - publication:references
  - date
  - section
  - page_number
  - pillar_order
  - kind
  - title
  - subtitle
  - reporter
  - email
  - quote
  - body:text
  - image:text
  - graphic:text
  - char_count:integer
