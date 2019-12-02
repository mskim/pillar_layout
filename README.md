# StyleGude

Rails app for creating style guide for newspaper publication

## Tables

### paragraph
  working_article:references
  name
  order:integer
  para_text:text
  tokens:text
  
### column
  working_article:references
  order:integer
  column_type
  x:float
  y:float
  width:float
  height:float

### body_line
  working_article:references
  paragraph:references
  column:integer
  order:integer
  string 
  x:float
  y:float
  width:float
  height:float
  line_type
  text_area_x
  text_area_width
  <!-- next_line:integer -->

<!-- ### token
  order:integer
  paragraph:references
  line_fragment:references
  token_type
  string
  width_array:text
  x:float
  y:float
  width:float
  height:float -->

### reporter_image

### reporter_graphic
  #  user_id        :bigint(8)
  #  title          :string
  #  caption        :string
  #  source         :string
  #  wire_pictures  :string
  #  section_name   :string
  #  used_in_layout :boolean
  # has_many_attached :uploads
  # has_one_attached :finished_job 

### expert_writer
  #  name              :string
  #  work              :string
  #  position          :string
  #  email             :string
  #  expert_image     :string
  #  expert_jpg_image  :string

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

### section
  profile
  column
  row
  ad_type
  is_front_page
  story_count
  page_number
  section_name
  layout
  color_page

  #--------
  issue_id

### ad
  name
  korean_name
  page_columns
  column
  row

### image_template
  parent_column:integer
  parent_row:integer
  column:integer
  row:integer
  height_adjustment_in_lines
  image_path
  caption
  caption_title
  position      # top_right, bottom_right, top_midddle, middle_middle, full_height

  <!-- top_offset_in_lines:integer
  bottom_offset_in_lines:integer -->
  profile
  parent_id:integer

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


  
## page_library
  slug
  tag
  ad_type
  page_coumns
  story_count
  config:text

# email based layout?
  references:issue
  template_id:integer

## combo_ad_box
  - base_ad
  - column
  - row
  - layout: text

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

TO: publication_name@naeil.design
subject: 3x4

---
title: title of Article
subtitle: subtitle of Article
___

body text goes here.
