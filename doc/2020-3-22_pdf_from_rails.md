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

## page
  no longer need to do update_pdf_chain
  just place image from working_article
  we no linger need to save config_file.yml
  may not need to save working_article pdf?
  
## working_article

no longer need to do update_pdf_chain

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
  - x
  - y
  - width
  - height
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
  - lines:text, Hash {column:0, order:0, tokens: []}

body_lines
  - workinng_article:references
  - column:integer
  - order:integer
  - x
  - y
  - width
  - height

working_article

def generate_pdf_with_ruby

end


def generate_pdf_with_ruby

end