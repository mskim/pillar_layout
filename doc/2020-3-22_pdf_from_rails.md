# Genrate PDF from Rails

The idea is not to bother to use RLayout, but to generate PDF straingt from Rails

WorkingArticle
Headinng
Image
Graphic
Leading
Page 
PageHading

They all should gerate PDF drawing code given canvas and options

## working_article
def draw_pdf(cancas, options={})
  draw_columns
  draw_heading
  draw_subtitle
  draw_images
  draw_graphics
  draw_group_image
  draw_paragraphs
end

### tables
heading
  - x
  - y
  - width
  - height
  - title
  - title_style
  - subtitle
  - title_style
  - top_story

subtitle
  - x
  - y
  - width
  - height
  - title
  - title_style
  - subtitle
  - title_style
  - top_story

leading
  - x
  - y
  - width
  - height
  - leading
  - leading_style
  - position
  - kind
  - column
  - extra_space

announcement
  - announce_style
  - announce_string

paragraph
  - body_style
  - empasys1_style
  - empasys2_style
  - prefix
  - lines_before
  - lines_after
  - tokens:text, Array
  - lines:text, Array