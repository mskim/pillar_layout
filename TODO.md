# TODO

- make demo video
- make user manual
- enable ace editor/Trix, or Quill
- paginate remote with kaminari

## get record with unique field (:layout)

- Section.distinct.pluck(:layout)
- fill_up words for article template
- use key to summit
  - parse svg and make pdf
  - page_headings
      - SVG to PDF
  - short key
  - progress wheel

  - body
    - fit_text

  - classified_ad
  - upload_first_page_heading
  - download_first_page_heading
  - heading_maker

  - upload Excel file for issue plan 
  - issue_set-up.rb file preset article types, by day_week, page, pillar_order  
  days = %W[mon tue wed thur fri]
  set_up =[
            [days[0..5], '22','1-1', '기고'],
            [days[0..5], '22','1-2', '기고'],
            [days[0..5], '22','1-3', '사설'],
            [days[5..5], '22','1-1', '기고'],
            [days[0..5], '23','1-1', '기고'],
            [days[0..5], '23','1-2', '사설'],
    - do the layout in rails
      goal is to edit content by components and update olny changed parts,
      instead of relayout the whole aricle from scrach.
          - get token width 
          - create Style in TextStyles,  so that every user can share, since we are using 
    - body by paragraphs
    - heading
    - quote
    - image
    - graphic
    - announcement
    - group_image
    # TODO find font_wapper from font name
    - use Redis for speed improvement
    - use TablePlus for taking data from 213 to apply to 177

2020_5_8
  - create 부고, 인사, as float
  - overlap as 첨부기사?, 기사첨부?

2020_5_7
  - create website
    - create sample website
    - web desking

2020_5_6
  - side_drop
    - handle adjustable_height push
    - divider line for side_drop
  - chidren
    - handle extended_line
    - divider line for chidren

  - fix image fit_type, crop
  - mixed token style in same line
  - fix empty space when last token has "mark
  - show pictures from wire
    - 나의 기사, 섹션으로 출고
  - 기사 첨부, 1x1, 1x2, 2x2, 3x3

2020_5_5
  - issue/1/firt_group_stories, fix display number

2020_5_1
  - right_drop 
    right_side article starting at given article and drop to the bottom of pillar
  - left_drop
    left side article starting at given article and drop to the bottom of pillar
  - right_overlap


2020_4_30
  - side_drop
    side article starting at given article and drop to the bottom of pillar
  - side_article
    only expand in the current article
    
  - overlap
  - fix image fit_type
  - fix image cliping
  - add frame_bg_color to boxed article

2020_4_30
  - right_drop
  - left_drop
  
    1-L, 2-R
  - article_sidebar_right_1
    1-1-1_R2
    1-1-2_R2

2020_4_28
  - 7단 기사 에서 자동행조절 하면 오른쪽 기사 위로 올라감 제목 넒이가 6단 만 가림
    fixed change @text_area[2] > 10 to 20
    def unoccupied_line?
      layed_out_line == false && @text_area[2] > 20
    end
NameError (undefined local variable or method `token_options' for #<RLayout::RParagraph:0x00007f9700de34d0>
Did you mean?  token_string):

  - 아동·청소년
  - Root article shoud manage its children, instead of pillar managing it. 
  - add ancestry:string to WorkingArticle
  - WorkingArticle has_ancestry
  Root article should make things much simpler to add, delete additional article on right, left, or overlap
  only root article belongs_to pillar
  root article also should handle 
    - PDF merging
    - svg view generation

  naming convention
    root article 1_1
    children article 1_1_1, 1_1_2, 1_1_3
  - add working_article has_one: layout_node
  - layout_node belongs_to :working_article, optional: trie

  - 2020_4_28 기자이름 영문일때 우측 space
  - 메인가사 자동 설정

2020_4_27
  - fix v_split at 2 from right
  - fix pillar#remove_article
    - update back to 2_2, when  2_2_2 is deleted
  
  - fix split_box 에 기사 추가?
  - add 기사 after, before
  
2020_4_26
  - add node_layout_id:integer  to working_article
  - media_plan
      news
      Forum
      section_plan
      ad_booking
  - cms
      my_story

2020_4_23
  - 사진 기사 박스 일때 테두리 두께 

2020_4_22
  - 새로자르기 에러, 
  - 새로자르기 후 자동 행 조절 적용 않됨
  - 사진 편집창 에서 사진이 여러게 일때 button 반복 에러
    http://211.35.70.177:3000/working_articles/2537
    
2020_4_22
  - 기사 상단 여백 1행 광고여백 수정후 틀어짐
  - 사진 테두리

  - add v_cut
    - make suer we have properly formed layout_node
      some layout_node seem not to be properly formed

  - 사진 크기 자동 행조절 후 변화
  - when line breaking '글  or  "글  space is put in place
    giving error 
    ·   and ~ similar font not supported
    # 183
    # 126

2020_4_21

  - add def max_pushed_line_count
    This limits pushed_line_count, so that bottom articles do not get pushed too deep.
    If articel is pushed too deep, we can not click it.
    Bottom articles will get stacked at minimun of 1 row height each.
    User will need to delete the bottom article before growing article too tall
  - 사진 그래픽, 최적 않됨, need image crop 
  - prepare_issue with page_plan index
  - fix ^ becomes body style
  - graphic 바꾸기
  - display original file name 

2020_4_20
  - fix node_layout leaf_node_layout_with_pillar_path for single node


2020_4_17
  - draw line at the bottom of 사진기사
  - opinion 자동 행 조절시 제목 위로 본문 침범
  - 광고 1줄 올리기
  - 세로 나누기란 표현을 / 기사박스 나누기-좌우/ 기사박스 나누기-위-아래 이렇게 바꾸면 안될까?
  - delete working_article
      new_layout gives flat level array of if there are only one article box[0,0,2,5, nil]
      where as we are expecting Array of rects this gives an error 
      at pillar.rb 
    
2020_4_15
  - profile save_pdf_in_ruby, save_pdf_with_ruby error
  - fix editorial position moved to top
  - make working_article hi-res
  - jpg cmyk picture showing as reversed

2020_4_14
  - fix ad_box layout error
  - image and graphic position not appying, graphic fit
  - image reversed

2020_4_12
  - draw page divider, 
    - add color page checkbox, and divider checkbox
    
  - split vertical
    - left_most box determines height, right side siblling are bound to this height
    - x_2_1 except bottom can be auto_adjusted
    - bottom articles should be pushed down as acorrding style 
    - add vertical cut
    - add level 3 horizontal cut 

  - Spread Ad
  - add preparing issue_plan before ceating new issue 
    - upload excel, preview, and create new 
  - add sand_box issue before ceating new issue 
    - add  사전제작용 move page content to currnt issue
    - add copy_to_current_issue menu in sand_box 
      working_article to move sand_box content to current_issue  working_article
      entire page to move sand_box content to current_issue page 
  - hyphenation enhencement

2020_4_11
  - fix bottom_article y_position error after auto_adjust
  
  - fix covert_pdf2jpg
  - convert pdf2 jpg at high res
    - need page_preview high_resolution
    - i should try saving pdf image on a larger page and save, then convert that to jpg

  
2020_04_10
  - 10면 맨 위 그래픽 on_left_edge, on_right_edge
  - checkbox to make article top_article
  - 자동 높이 조절시 사진 위치 변경
  - fix bottom_article height after auto_adjusting article
  - fix editorial stroke_sides

2020_04_9
  - opinion and book intro heading 4 lines
    - redo container_pdf_view save_pdf_in_ruby
    - change Hevetical-light to KoPubBatangPM ???

2020_04_8
  - menu coverted by nav-bar in PC
  - remove 박스기고 from kind popup
  - use box with 테두리, no 박스기사
  - add opinion with profile image at bottom right
    - draw full column line on top of subject_head
    - fix profile image 홍길동 image fit 


  - fix line edge drawing, shift position inwards 
  - graphic fiting 


2020_04_7
  - make bottom_article to be pushed, but maintain the position at the bottom
  - display it with clickable area 

2020_04_6
  - editorial not showing title, lines
      heading_for_title draw_pdf
  - task to convert person_image.eps to person_image.pdf for opinion and profile
  - fix error when generating subject_head in editorial
  - draw_sides
  - friday opinion 

2020_04_5
  - user PDF image instead of EPS
    - check to see if we can convert EPS with clip into PDF with clip info
    - yes  we can
     cd to_image_path && convert -density 300  filtered_name.eps filtered_name.pdf
  - OpinionWriter
    - convert EPS to PDF with path
      convert -density 300  홍면기.eps 홍면기.pdf
      generate_jpg
    - do the same for profile
  - OpinionWriter

  - opinion page, editorial page

  - replace heading pdf that was causing error 

  - merge personal_images to single folder

  - 아래와 기사 바꾸기
    - change pillar_order 

  - 세로 자르기, undo
    - 1-2-2-1
    - 1-2-2-2
    
  - fix crop 
  - graphic file fit_type
  - put graphic file name

2020_04_3

  - display add_article menu at bottom article
  - display remove_last_article menu at bottom article
    if pillar has more than 1 article

  - set expanded_line_count to 0 not changeing the value
  - artitcle box height being sqeezed, not caculateing y position and height
  - image caption position in side image
    image should align to top
  - mixed token for body  ^ for reporter
  - refresh page and working article after tempale change
  - regenerate opinion profile images with ruby_pdf
  - draw line
  
  
2020_04_2
  - add remove_last_article


2020_04_1
  - download page_layout csv
  - 전면 광고 하시라 없음
  - 양측 기사 여백 지우기 on the edge error

  - 2면 20면 광고없음 다른 템플렛으로 바꾸기 에러
  - auto adjust_height page config error

2020_03_31

  - fix adjustable height layout error when overflow
  - fix title subtitle adjusted point size not applied
    - fix space_width
  - fix adjust_height
    - display bottom article adjusted line
    - fix bottom box y and height after adjust_height
    - fix page config update
  - draw tittle, subtitle, overflow red mark
    
  - rjob from ruby
    - ad_box
    - page_heading
    - opnion
    - profile


  - 177 page not creating, only 6 page created

2020_03_29
  - caption_column draw_pdf
  
2020_03_27
  - page add has_many working_articles

  - stamp_page_pdf
  - ad_box sample folder
    - call copy_from_sample to check if sample exists
  - article_sample folder
    - copy_from_sample
    - profile 
      page-column_column_row_top-story
      page-column_column_row_top-position
      page-column_column_row_middle



2020_03_26
    - not working
      - ## 고딕으로 
      - ### 고딕으로 
      - #### 20면 으로 연결
    - fix error when auto adjust height
    - page_layout edit error
    - update_pillar_from_layout, when editing page_layout

2020_03_25
  - 5단 에서 광고없음 으로 변환시 에러
  - layout 변환시 에러 177 
  - change rjob to use ruby_pdf

  - caption not showing
  - #### arrow symbol not in the font
  - **emphasis**
  - draw article lines
  - article box height

  - ui update
  - make regenerate_page
  - cropping not working
  - fix editorial head not showing if image is preosent

2020_03_24
  - fix subtitle disapearing when image is present
  - page_layout [0,0,3,4,0] handle invalid 5th element

2020_03_23
  - fix bug when changing page_layout when new pillar size is not equal 
  - fix update ad_box when change_page_layout

2020_03_22

  - change how page pdf is merged, just merge working_articles from page
    - get rid of update_pdf_chain
  - get rid of page config.yml file, no longer needed
  - fix generate_pdf for page_heading, use ruby
  - fix save_pdf_page  working_article y, position
  
2020_03_20
  - show jpg in chrome
  - add  `draw_pdf' for NewsColumnImage
  - update font table from 213

  - 자동 정렬 에러 사진 올리고, 기사 swap update pillar_order
  - make high res jpg
  - add font attributes when drawing
  
2020_03_20
  - apply font to title, head

  - display uploaded file name image and graphic
  - opinion title not showing when picture is present
  - article subtitle not showing when picture is present
  - ###  not working
  - #### font for triangle not found
  - image upload shifting to top, maybe due to fit_type error
  - fix editorial draw_pdf

2020_03_19

  - fix ## font not applying
  - fix title , #### not aligning properly
  
2020_03_18
  - fix uploading pdf file
    use vips insread of imagemagick
    use image-processing with libvips
  - fix change_page_layout
  - fix opinion view show column size
  - fix opinon, profile,index view as multi-column
  - fix opinion picture vertival size, fit_type FIT_VERTICAL
  - fix opinion view reporter default value as '홍길동'

  - copy data opinion profile from 213

2020_03_17
  - 전체 오피니언 기사종류 select 없음
    - make it work (아랫부분 select 위치 수정)
  - 먄배열표 광고 바꾸기 not working
    config_file ad_type not updating
  - page change_page_layout
    - update page column
      - show page_layout choices in grouped by column 7,6
    - update pillar position
    - updaet working_article size
    - save config file
  - paeg_layout 복제하기 변경 내용 등록 안됌
    - list in order of updated_at so that last modified is at top

2020_03_16
  - fix issue_plan not update page
    - make section_name and display name
    - 정치(코로나 바이러스 비상)

  - fix issue_plan not updating ad_type
  - rails g migration remove_layout_with_pillar_path_from_page_layout 
  - fix page chage to new layout
  - fix new page_layout, add duplicate, fix serialize layout to just text
  - fix subtitle disaprearing when there is an image
  - fix article_info saving
  - fix bridge_ad
  - upload excel file for issue(won ho)
    - use carrier_wave

2020_03_14
  - add page_layout template for page 1 in page_layout.csv
  - PageLayout, duplicate, edit
    - page_layout.update_pillar_from_layout
    - pillar update_pillar(layout_item,)

  - fix bug when there is an image, subtitle not displayed
  - fix bug uploading graphic error


2020_03_14
  - fix layout in PageLayout as just text
    - get rid of serialize :layout, Hash just do eval(layout)

2020_03_13
  - fix edit page_layout
    - fix edit form
    
2020_03_12
  - fix auto_adjust_height
  - fix virtical cut 
  - fix horizontal cut 

2020_03_11
  - fix page column nil value
  - fix page_layout.csv first page pilliar height
  - fix pilar_bottom?
  - fix layout_rb pushed_line_count for pilar_bottom?
  - fix extended_line_count save
  - fix top_story? assing it at create, has to have column with > 2

2020_03_09
  - we no longer need to update config file
  - fix bottom_article? to bottom_article_of_sibllings?
  - fix menu for pillar_bottom_article
     if @working_article.bottom_article_of_pillar?

  - fix bottom article height according to reduced_line_count

  - update horozontal sibling height when height is changed
    - tallest or left most???

2020_03_8
  - fix clear_crop_rect
  - fix shorten initial body text as ""
  - fix title space width
  - fix overflow red line for ruby_pdf_engine
  - use cmyk color

  - when article extended_line_count is changed, 
    update bottom article pushed_line_count
    
  - when article height height was adjusted is changed, 
    update bottom article pushed_line_count

2020_03_6
  down sides of setting adjustable_height and updateing
  articlde height
    - too many moving parts
    - set adjustable_height as false as default
    - chang the height only when specified
    - use specified number 1,2,3 or auto expand and recude 
    - set height expand back to 0
    - auto adjust height for all articles
    - revert to original all articles height 
    - use empty body text

  update bottom, element pushed value every time above pillar sibliings height is changed
    - y_offset_in_lines
    - height_in_lines

  do not save article_info to disk, if ruby_layout mode
    - layout_status:text
      hash of current layout_status
    - get return values from ruby layout
      - overflow, overflow_text, underflow info

2020_03_05
  - overlap = 첨부박스
  - fix heading not showing
  - fix pillar bottom position box layout
      it should be layed out as fixed height

2020_02_12
  - fix page layout error
  - clear crop_rect
  - cut_vertically
  - make overlap_article
    - add overlapable?
      - depth must be greater or equal to 2
      - column > 2 && column > 2
      overlap 한글이름 달린박스? 기생박스?
    - add/remove overlap in menu
      - 달린박스 추가(하단우측)
      - 달린박스 추가(하단좌측)
      - 달린박스 삭제
    - add kind overlap(기생박스)


2020_02_12-3
  -  height locking
    - height can be locaked at row , pushed, expanded suppoert not supported for pillar article

  - overlap condition
    - overlap is allowed for level 1 or 2 aritlces only.
    - only one overlap is allowed per article
    - overlap is leveled with alphabet, ex 1_a, 1_1_a
    - overlap containing article's size gets  locked, it's height becomes non-adjustable_height ???
  
  - set auto tracking for ajutified line
    - when word spacing is too tight set -tracking for tokens
    - when word spacing is too lose set +tracking for tokens
    - to not break numbers and comma included numbers

2020_02_12
  - on Page show display available PageLayout
  - Pillar has_one LayoutNode
  - LayoutNode belongs_to :Pillar, optional: true

2020_01_30
  - Pillar
    presents area of page with related article boxes
    A page can have one or more pillars, and each pillar has one associated LayoutNode

  - LayoutNode
    tree reprensenting relation of article boxes, where leaf nodes are article boxes.
    leaf nodes can be cut in vertivcal or orizontal direction to form more leaf nodes.

  - difference between layout_with_pillar_path and layout_with_node_path ?
    pillar_path adds pillar_order in front of each node_path

2020_01_29
  - steps for creating page_tempates(section)
    1. create page_layout from csv
        1. create pillars and nodes from this
        1. create odd pages from page_layout
        1. create even pages from page_layout

    2. create initial sections from existing csv
        1. parse section data and retreave pillars from it

  - add v_divide to working_article
    '세로 자르기 -1'
    '세로 자르기 -2'
    '세로 자르기 -3'

2020_1_15
  - add variable_page_count:boolean to publication
  - add page_count to issue
  - add change page_count selection to issue show button
  - add change page_count to issue model
  - add change page_count to issue page_plan view
  - add change page_count to issue_controller
  - add get page_count to route.rb
  - add change page_count to page_plan model

  - read page_layout from section.yml
    - add pushed, extended to page layout? try to avoid this!!!
      - add height_in_lines to pillar, working_article
    - add article type specification to page_layout?

  - add spread
  - update ytn parsing

2020_1_6
  - fix issue_plan to support variable page size
  - fix editorial reporter image position 
    - top_left, bottom_right, none

2020_1_2

  - bug 수정
    - 2단 제목 넘침?
    
    - 이미지 크기 위치에 따라 변환 방지
    - 그래픽 높이 자동 조절 
    - 우측 인물사진
    - 이미지 caption 제목과 설명 간격 수정
  
  - 면배열표 수정 내용 한번에 적용하기
  - 그룹사진 기능 구현
  - 양면광고 구현

(한승효)
  - 광고 자동 배치
  - 펼친면 광고
  - xml 없는 글자 대치 하기 방식수정: 제목, 본문 등 한꺼번에 hash를 사용하여 대치하기
  - 10면 없는 날
  - engine pdf 생성 방식 이전(newsman.app 없이 pdf 생성하기)
    - 이미지 크롭 (장원호)
  - pillar(기존 section 디자인 활용)
  
  - 연합 이미지 불러오기 guard 지원 속도 개선

  - 교열 기능 구현
  - web site 자동 생성하기 구현
  - 표 자동 생성하기 구현


2019_12_24
  - fix working_article show page.to_svg_with_jpg cut off on left edge
  
2019_12_20
  - fix svg text position
  - fix svg link position
  - fix pillar height with heading_space
    사설
    기고
    박스기고
    기고 && row >=10
    

2019_12_19
  - add table GroupedImage
    caption, caption_title, source

    has_many :member_image
    caption, caption_title, source

  - add table MemberImage
    order caption, caption_title, source
    has_one_attached : member_image

2019_12_18
  - add more page_layouts by 1, even odd, 
  - show column in page_layout svg
  - fix change_page_layout
  - show more page_layout_choices
  - add 9단21 page

2019_12_17
  - add admin panel where admin can fix
      user
      working_article
        overlap
        image
        graphic
      page
        section_name
      issue
        date, number



2019_12_16
  - redo NewsArticleBox layout

  - opinion box
  - quote_box
      position
      column
      heights_in_line
      alignment
      v_alignment
      sides
  - text_box
    - empty_first_column

  - administrait
    - working_article, image, graphic, issue, page, reporter, ad_box


2019_12_11
  - rails app for 
    -uploading images to DigitalOcean
  - fix image upload
    has_many_attached :storage_images



    #individual_caption
    has_many_attached :storage_grouped_images
    position, direction
    row, column
    working_article:references

  - adjust initial body text length by article area
  - add proof to page
    has_many proofs
    
    proofs 
      has_many comments
      version:integer

    comments
      belongs_to :proof
      user, comment, x, y, width, height, color    

2019_12_10
  - add change page_layout to page view
  - change_pillars

2019_12_9
  - sample_issue
    copy issue_sample when creating new issue instead of generating

2019_12_8
  - read only database table
    - parse wire_service
    - put selected images to cloud

  - working_article
    - fix bottom article 
    - fix ttf font tracking

  - rename region to region 

  - BodyLine
    references WorkingArticle
    order:integer
    x, y, width, height
    column_index, line_index, overflow:boolean
    tokens:text serialize :Array
    
  - Heading
    title
    subtile
    subject_head
  
  - Quote
    style
    text
    column

  - GroupedImage
    - has_many :images as:imageable
    - Image as polymophic true as imageable

2019_12_7
  - upgrade rails to 6.0.1
  - PageLayout adjust pillar position for front_page
  - try using ruby pdf 
  - chnage pillar svg selection view with even height
    - replace it with page svg with selected_pillar_page
  - fix top positon article page_heading_height_in_lines

2019_12_6
  PageHeading
    top_position?
    front_page pillar box grid_height
      - page_layout if page_type is 1(front page, make different pillar height)
    create layout_rb
    move bg images from page_heading folder

2019_12_5
  fix pillar x position in page

  fix bug when changing pillar
    need to update size and delete the execess

  in working article show
    tab return to edit
    move price and other stuff to bottom
    fix ad_box show  

  bug when reducing pillar from 5 to 4
    some article box draw in svg view

  in Page
    - create AdBox
      generate pdf at creatiion
      9단21, 7단16 홀 짝
    - create PageHeading

2019_12_4
  - change_
  - in seed
    - LayoutNode generate only for the PageLatout pillar sizes
  - Pillar update_pdf_chain
    time stamp pillar pdf
  - change_position
    - pillar
      def change_article_position(currnt_article, new_position)

    - page
      def change_article_position(currnt_article, new_position)

2019_12_3
  - layout.rb
    - on_right_edge
  - config.yml
    - grid_size
  - 광고없음 unicode

2018_10_1

  - add proofs to working_article
    working_article
      - has_many :proofs

    proofs
      - references:working_article
      - has_one_attached :proof_image
    
    comments
      belongs_to :item
      - references:proof

      - name
      - text
      - image
      - x_value
      - y_value
      - width
      - height

2018_10_12
  - convert section data into pillar data
    - rake style:section2pillar

  - download_page
    - zip the page folder and download page for debugging
    - prepare for download
        - move images to local folder
          - article images, graphics
          - ad image
        - set the image path

2018_9_25
  - add_sides_to_working_article
    - left_line:integer
    - top_line:integer
    - right_line:integer
    - bottom_line:integer
  - add_sides_to_image
    - left_line:integer
    - top_line:integer
    - right_line:integer
    - bottom_line:integer

2018_4_25
  - replace grid_y and pushed with y_in_lines
  - replace row and extended with height_in_lines
  - layout_rb save height_in_lines
  - move_by(line_count)
  - move_sibllings_by(line_count)
  - autofit_by_height
  
2019-4-18
  - 부고 줄 길이 수정
  - save_as_template
    - save heading and ad
  - template 바꿀때 기사 지워 지지 않음
  
  - 본문박수 부제 크기 칼라
  - 사진 엥커 죄우

  - 사진밑 여백 새로운 버젼 에서 에라
  - 문페에 ** ** 깅조
  
2019-4-17
  - 다. hyphenation
  - hangling functuation?

2019-4-16
  - box-ordering
  - save_as_template(normalize to extend and push to nearest grid)

2019-4-16
  - 수정중?
  - order numbering
      show number show char_count
  - merge_siblling
  - split_box

  - 사진 2개 올릴때 동일한 이름으로
  - 나의 기사에서 입력한 문패 저장 않됨
  - 템프렛 바꿀때 에러
    - check for invalid section template
    - show if it is invalid with red waring so designer can fix it.

2019-4-15
  - autofit_by_height
  - autofit_with_sibllings
  - autofit_with_image
  - save_as_template

    do not expand if the sibling is at the bottom and height is only one
  - save page as template
    - with pictues, extened_lines
    
2019-4-14
  - 사진 좌

2019-4-11
  - 부고 밑줄
  - 빈줄 수 사진이 아래일 경우
  
2019-4-10
  - add pdf generation in Ruby
  - block page printing if ad is not placed
  - 100년 
  - fix person_image
    - position
    - top_margin
    - right side

2019-4-9
    add_column :working_articles, :draft_mode, :boolean
    add_column :working_articles, :draft_values, :text
            image_extra_lines
            box_expand
            bpx_pushed
            auto_fit_mode  # autofit_by_image_height, autofit_by_box_height
            svg #svg text
    attr_reader :news_box_maker, #RLauout::NewsBoxMaker
        options[auto_fit_mode] = 'autofit_by_image_height' , 'autofit_by_box_height'
        
    
2019-4-6
  - 연합목록
    - 기타 카테고리
  - 6단면 제목 밑 부제목 가로 길이
  - 인물사진 좌우
    - 위에 여백 지우기
  - 가로 자르기
  - 세로 자르기
  - save page as template
  - 템플렛에 사진추가

2019-4-5
  - 연합연결
  - 사진기사 밑줄
  - working_article 넘침글 정확한 수자
  - 사진바꾸기 할때 면 PDF 생성
  
2019-4-4
  - 문패 윗줄
  - 22면 기고 

2019-4-3
  - 테플렛 변경시
    - working_article 지우면서 story도 지워는 버그
  - 기사 배정시 필터링
  - template 글자수
  - 박수크기 조절시 옛날글 지우기(stamped file)
  - 기사배정후 해당면으로 가기
  - style 수정후 pagination 을로 복귀 
  - page.generate_pdf_with_stamp 지난 파일 지우기

2019-4-2

  - 박스기고 
    - 중간기사 제목 높이
    - 좌측기사
  - 사설 첫행 들여쓰기
  - 사진기사에 그래픽 올리기
  - 사진박스에서 우겨넣기
  - 인물사진 위치
  - 연합뉴스
  - 이미지 빈칸 미리 자리 잡기

2019-4-1
  - fix 면배열표
    - ad_type = ad_type.unicode_normalize
  - 기자사진, 전문가 저자

2019-3-29
  - 사진 zoom & anchor

  박스기고
  - 회색 박스크기
  - profile_image
    - expert
    - reporter
    - advisory
    - quest

2019-3-28
  - ## 두줄 줄 바꾸기
  - ### 첫번째 줄도 양측정렬
  - * 싸기 때 마름모 와 = 빼기
  - ** 싸기 때 앞뒤로 반각 없이
  - 박스기고
    좌측 들여쓰기
    상단좌우에 선 지우기
    제목 한줄 더 띄우기

2019-3-27
  - 3단 부제목
  - 이미지 밑에 여백 생김
  - 발물 수정
  - 발문 테두리 상하 적용시에도 테두리 모두 생김.
  - 발문 단 너비 조정 안됨.
  
  - 기사 박스 교환시 새로 고침
  - 기자용
  - 나의 기사 순서
  - 기사배정 
  - 기사배정 해재시 error 

  - 본문 부제 삭제시 페이지 리제네레이션이 되면 어떨까요? 
  - 아래 박스와 기사교환시 페이지 리제네레이션이 필요합니다.

  - ## 중간제목 : 왼쪽 정렬 : 두줄기능이 필요.
  - **본문내고딕** 앞뒤로 반각 띄어쓰기가 안생기게…
  - ### 인터뷰질문 좌우맞춤 정렬 필요. (현재는 좌측정렬)
  - 텍스트스타일에서 직접 조절할 수 있게 분리 필요


  - 박스기사 밑에 부고..  제목이 붙어서 일반 기사의 문패처럼 처리하고 본문을 문패와 겹쳐지지 않게 떨어뜨려주세요.

2019-3-26
  - add display name to page
  - section nameing convention
      정책(우리는 좋다)
  - add 3단 부제목
  - 박스기고 inset

2019-3-25
  - put JungAng, DongA ip and passwork to ENV[]
  - reporter graphic
    - designer assign size
    - when uploading meno field

  - 면배열표 권한(국장님, 마케팅)

2019-3-20
  - 광고 upload
  - 사진 테두리 없음 checkbox 추가
  - 금융팀 증시 구분선 없음
    사진 panel 에서 테트리  un-check
  - reporter_graphic
    column         :integer
    row            :integer
    extra_height   :integer
    status         :string
    designer       :string
    request        :text
    data           :text
    attach ytn_graphic to reporter_graphic
    download reporter_graphic for edit
    upload reporter_graphic final

  - 기자 profile menu 추가
    upload 기자 image
    기고저자 와 비슷하게 
    리스트

  - 사진 anchor point

2019-3-19
  - 매일 사용않된 출고물 해제
  - save_page for future (나의 페이지?)

2019-3-18
  - 섹션 템플렛에 색션 이름 적용
  - working_article 사진에 출고된 reporter_image 보여주고 선택 하기
  - 그래픽의뢰 + reporter_graphic 합치기
  - 그래픽의뢰 attachment
  - ActiveStorage
  - 인물 사진 높이 + 1
  - 사진 설명
  - 인물_우측 우측여백
  
2019-3-14
  - section template by section name
    - 1면, 정치, 오피니언
  
2019-3-13
  - image_fit_type
    - fit_virtical, fit_horizontal

  - graphic_requst attachment
  - ActiveStorage
  - attach resouces to story
    - image, graphic, library
    나의 이미지 출고, 나의 그래픽 출고

  - library_image
    - for image and graphic
    - add selected, section_name, date

2019-3-12
  - add wire graphics

2019-3-8
  - image_group
  - quote layout
  - fix quote left side text flowing bug
  
2019-3-7
  - 나의 사진 출고
  - 출고된 사진으로 이미지 편집
  - 부제 삐침
  - 발문 이미지 처럼 위치 선정
  - 이미지 정보 미리 지정하기


2019-3-6
  - reporter input add 문페 field, kind

  - ytn image selecting
    - fix fields names
    - show the image

  - graphic_request attachement
  
  - select image from collected
  - image 출고
  - image uploade, show image attributes before uploading

  - quote_box
  
2019-3-6
  - 부고-인사: show subject_head and body
    fix f.select so that the item shows up first
  - load 연합 sample
  - fix personal image
  - add quote columns to working_article
  - add partial views
    박스기고, 
    특집, 책소개
      quote 
       quote_box_size # 2단 3단
       quote_position
       quote_x_grid
       quote_v_extra_space # 
       quote_alignment # 
       quote_line_type # 

2019-3-5
  - 박스기고
      양측 여백
  - 부고
    subject head space_after 
  - 특집,책소개
      - 1단 본문없이

2019-3-5
  - 인물사진
  - 부고

  - 그래픽, 이미지 욱여넣기
  - 연합연동
  - 광고예약
  - 배열표 

2019-3-4
  - 사진 종류: 일반, 인물_좌, 인물_우, 구룹
  - 관련없는_사진
  - heading_folder
  - template_folder
  - 연합기사 sample

2019-3-2
  - make page_plan for future 14 days
    - add simple_calendar
  - add personal_image (left, right)
    - add imge_kind:string to image table
    - rearange subtiltle and personal_image
    - 시작 단

2019-2-26
  - 1번이 그래픽이나 사진이면 2번이 top 기사
  - save text_style to local yml
  - save section to local yml
  pront_status
    - add last printed time

  인물사진_좌, 인물사진_우
    - 제목 부제목 인물사진 

2019-2-25
  - graphic_request attachment file
  - file should 
  - 기사에 사진 그래프 여부
  
2019-2-22
  - group image, 반단 이미지 0.5 for right, -0.5 for left
  - graphic_request
    - table_maker
    
2019-2-22
  - 제목 넘침
  - 기사 배치 
    선택 된 기사는 다른 기사 보여주지 않음, 해지만 
  - section order id and created_at desc

2019-2-21
  - 면배열표 저장
  - 9단21 홀짝 광고
  - delete story from working_article, when story is un-assigned

  - update story from working_article

  - 연홥 뉴스 연합 사진
  - fix multiple image upload bug
    - 기획 팀 사진 3개

  - cms category
  - create advertisers list
  
  - 메뉴얼
  - save text_style.yml to local folder

2019-2-20
  - add partial seed rake task
    migrate:down ,  migrate:up, seed table
  - add YTM story, YTN image
  - add wait_for_stamped_pdf for page
  - graphic file name 6-2, 7-2 ????
    when uploading graphic, detect filename and make the graphic box
  - add graphic_request
        date
        user:references
        designer:string
        instruction:text
          size
        data:text
        status :integer
          request_made, designer_started, designer_finished, accepted
        graphic

2019-2-18
  - add sucker_punch gem
      add ArticleWorker
      change generate_pdf_with_time_stamp to call ArticleWorker
      add wait_for_stamped_pdf
  - change text_style path to local rails_root/1/text_style/text_style.yml
      extract this path from article_path or section_path

2019-2-14
  - add title, description:text to graphic
  - put options to draw box around or not

  - 사진 implement it fit_type in Newsman 
      - adjust_box_height_to_image (image, graphic)
      - add draw_frame to Image and to Graphic

  - add YTN story
  - add YTN image
  - 전체보기에서  CMYK 표시
  - 광고주명 입력 혹 display selection 
  - 합성광고 id 표시
  
2019-2-13
  - 광고 목록, show svg layout
  - sort section layout, move ad box to last
  
2019-2-12
  - expand pushed for multiple child section 118, 119


2019-2-11
  - 7단 일 경우 제목 크기 설정시 본분이 올라감 상단 여백 에라
  - 중간제목 행갈이
  - x_grid  start at 1, not 0

2019-2-10
  - add status to page
  - add send story, and wire_image from wire_service to newsGo 
  - add recieive story to newsGo 
  - add testing to StyleGuide
  
2019-2-2
  - combo_ad_box
  
2019-1-31
  - make default issue_plan as last issue_plan
    make marketing ad_plan as issue_plan
  - when working_article kind is changed to image,
    delte all text including subject_heading and save it.

2019-1-31
  - combo_box
    - base_ad
    - width
    - height
    - column
    - row
    - layout
    - profile
    - sub_ad_count

2019-1-30
  - image x_grid
  - graphic x_grid
  - when changing page_plan,
      check for page and ad_type to make sure that first page template does not get applied to inner page with same ad_type
2019-1-29
  resources :ad_boxes do
    member do
      patch 'upload_ad_image'
      get 'download_pdf'
    end
  end

  - 줄 늘이기 여러개 할 경우 에러
  - image fit_type
  - current_page, current_working_article

2019-1-28
  - boxed_subtitle_text delete it from db when not used
  - space between section_name

2019-1-25
  - 검색 메뉴추가
    페이지검색, 
    page edit tag
  - 기사 검색
    with one word search all field
  
  - add to Page closed:boolean
  -  lock page to make it uneditable
  - copy page
    as template
    with content
  
  - page library
      b 판  heading 수정
      copy to data and page(template or source)
  
  - 반단 사진 (.5 width)
    sub_grid_size
    
  - 부고/인사 박스 (obituary)
    제목 업고 부제목 간격

  - 특집? (special)
    테두리 [1,2,1,1]
    2 - 3단 
    문페
    제목 1단에서 시작
    
    기자사진

    - 사진 그래픽 xml 용 필드

  - 

  - 책소개 (book_review)
    - 사진 형태 반쪽 사진설명 우측

2019-1-24
  - 욱여넣기
  - in image and graphic size_string
    extra_height_in_lines = 0 unless extra_height_in_lines
  - 제목 없으면 제목박스 없이
  - text 영역별 글자수 계산
  - reporter_image 추가 
    - 나의 사진

  - b판
  - heading 바꾸기

  - 현제 page 를 템플렛 으로 저장/사용
    페이지 레이아웃 검색 날자별 
    칼렌더 UI for searching page

2019-1-23

  - update page pdf, when story is assigned
  - when line number is expanded, 
    working_article pdf doen't get updated even page pdf is updated

2019-1-22

  - empty image box with no uploaded image
  - replace uploaded image with another one
  - crop image
  - image fit_type

  - fix caption title
  - fix swap story error
  - story_asign unasign_story

2019-1-17
  - when page_plan section_name is changed, update page section_name, generate_pdf for page_heding
  
2019-1-15
  - image fit_type
  - image cropping
  - ad_booking calendar
  - caption title
  - story assign UI

  - concurrent-ruby
  - change pdf engine to ruby-rlayout
  - wire-service
  - BoxAd
  
2019-1-10
  - 면배열표 광고 정보 AdBox 로 저장 
  - 기사 배치 기사에서 설정 할 수 있도록
  - 정치면 이외면 적용
  - 왼쪽 9단21 광고 템플렉 꼬임 
  - 광고 입력 창 날짜별 한번에
   
2019-1-6
  - when page template is changed, make sure heading background is copied.
  - 저장된 단락스타일로 페이지 재생성할때 타임 스켐프로
    
2019-1-5
  - 기사 배치
    - 행정 과 정책 바뀜
  - image size, graphic size
    - make extra space inside picture area
  - size of image in cm pt
  
2019-1-4
  - story does not appear on page assignment page
    put date section 
    put page order if selected 
  - fix page heading background image not showing 

  - ad_plan input by date enter daily add at once per page
  - fix 저장 to take effect as 수정 botton in image and graphic panel 
  - 브리지 광고

2019-1-3
  - 1, 3, 5,  7,  9, 11 default color page
  - 24, 20, 18, 16, 14
  - story list size reporter 
  - 광고없음

  - add emphasis on subject_head
  - add text on top of image?
  - show image/column and grid size in pixels/cm

2018-12-27
  - add heading_columns to working_article
  
2018-12-26
  - add Category
  - fix speread
  - fix oveflow count

2018-12-23
  - #, ##, ###, ####
  - *, **, markup 다이아몬드 강조, 고딕강조
  - print status monitoring
  - article 
    spit, 
    expand_grid, expand_grid
    expand, reduce
    syblling, cuson
  
2018-12-21
  - add ad_plan
    date ad:text description
  - generate heading when changing page template
  - 저장된 단락스타일로 재생성시 regenerate heading 

2018-12-18
  - fix change to no_ad 
  - 행정, 광고없음 not showing
  - image box at top no margin
  - 15단통_전면 => 15단통
  - 광고없음 적용않됨
    면 배열표 이름 이 반영이 안됨
    자치행정 not updated
  - 광고올릴때 동일이름으로 저장

2018-12-17
  - embargo
  - image trimming
  - automatic timeout
  - add 7x15_9단21_4
  - keep current section selection values
  - add '광고없음' to page_plan edit when selecting ad_type
  - in change_template of page, 
    - don't copy config from section, generate from page
    - don't copy ad from section, generate from page
    - this means we don't have to generate pdf for section

2018-12-14
  - intersection_rect, adjust to local codinate
  - save_xml
    - filter {size} from title, subtitle,
    - filter multiple line
  - page 광고없음
  - Section index keep current selection info
  
2018-12-12
  - overlap rect size should add 2 lines above and draw a line at 2 lines below
  - overlap y must be adjust to first rect최근 성룡코리건 그러면 소송한평균내가 아니라국고가 100 분이 더 하고 그건그거 그냥 보면 존경을 시도좀 우리 좀아닌가아닌데 몰래몰라요오긴긴 배우의 면면을 cordinate
  - frame around image 

2018-12-11
  - embeded article, line above
  - create empty image box

2018-12-10
  - fix token breaking rule, prevent it from too tight space
    pass currnt token(space) count, if space count is less than 4 do not give and cushion 
  
  - title and subtitle, text goes beyond right edge
  - image box with empty picture
  - image keep image info 

2018-12-8
  - overlapping box
     overlapping image as separate article
     working_article overlap_box:text
  - reporter byline
  - show selected page thumb
  - download opinion_writer csv with category_code

2018-12-7
  - 기획, 정책, 순서 반대로
  - title right side cuts off
      wrong heading width with non-edge 
      char cushion value
  - heading align to grid
  - fix when pushed and pulled in both
  - upload image with info intact
  - for picture box, hide picture size control
  - announcement vertical alignment

2018-12-6
  - fix section.csv seed format
  - add update_section_layout after create action
  - add generate_pdf_with_stamp when updating working_article
  - fix section svg unit_width as 210/column
  - fix siblings search
  - handle page 100(even), 101(odd) page template
  - fix drawing page svg with push and pull
  - fix push and pull bug, 

2018-11-30
  - fix 7단-15 bug
  - on issue_plan, selecting page ad_type for page
    present only the types available for page
    100 and 101 for even and odd page type

2018-11-28
  - 7단15 ordering bug fix
    when make article order, skip ad_box, it was causing mixup

2018-11-27
  - story 에 관련 사진 추가

2018-11-27
  - fix image position bug
  - swap story and 사진
  - swap between andy story and 사진
  - 안내문 템플렛 이동시 자동 위치 유지
  - 부제목 1, 2 단 선택
    1. 1단
    2. 2단
    3. 2단 2단시작
    4. 제목박스밑 가로

  - page_template with box template
  - page thumb, show selected
  
2018-11-20
  - 1면 4단 광고 우즉 여백

2018-11-19
  - image bottom and announcement  body_leading = 4pt
  - add 4단 section template
  
  - overflow bug when image is placed 
  - save xml
  - 9단 21 글자 밀어내기 over_lopping_box
  - 문체매인 1면 top
  - fix page svg codinate
  - title column_number

2018-11-12
  - add boxed_subtitle
    - add boxed_subtitle menu
  - add image fit type

2018-11-09
  - 박스문 추가
    본문박스(고딕_회색)
    본문박스(고딕_테두리)
    박스문 삭제
    ----
    안내문


  - image detail mode
  - image zoom, move, direction

  - section 
    - delte link to 6, 7, 
    - download_csv

2018-11-07

  - image change
      change image only without deleting captions and everyting else
      just change the image with same setting

  - expand when sybling is image

2018-11-07
  - update change made in issue
    - change page_template
    - set color to green if we have page
    - do not show create page once it is generated
  - subtile style
      고딕 보까시 박스
      스타일 추가 subtitle_s_gothic
      cmyk k=10
      테두리 0.3
      고딕_회색바탕
      고딕_테두리
  - image position 0
  - image position 7,8,9 fix it to align to bottom
  - working_article has_many_graphics
    - graphic uploader
    - tab for graphic uploader view

    - graphic no frame


2018-11-06
  - fix caption source right margin
  - image_grid_x position, - image_grid_y position,
  - update front_page_heading templates with ad_box in layout_rb
    - make image name as heading_ad.pdf
  - fix box_size changing bug
  - fix parsing article in Section, parsing ad as article

2018-11-05
  - add subject_head_S to text_style.yml
  - upload more than one image
  - update page_heading template with frontpage_ad with 
  - 9단21 홀/짝 ad_type
  - page_template thumbnail with box with number
  - mark current article with yellow

2018-11-01
  - fix caption_column last caption line align to left
  - page view template, show only the templates with current ad_type
  - front_page ad upload 돌출광고
  - fix bug when changing page template
  - fix working_article order
  

2018-10-31
  - announcement 안내문 
    - 안내문 붉은색 20, 100, 50, 10
    -            100, 50, 0, 10
    - 14, 9.6, < > 
  - view page template by category

  

2018-10-30
  - fix right side text cut off

2018-10-26
  - 5단면 지원
  - 안내문 모델
    - announcement_text
    - announcement_column
    - announcement_color
  - announcements table
    - name
    - kind
    - title
    - subtitle
    - column
    - lines
    - color
    - page
    - script

2018-10-23
  - add for_first_page:boolean to story
  - add sidekiq worker
  - fix assign_story_to_working_article

2018-10-22
  - fix slug for working_article
  - add sidekiq worker
  - fix assign_story_to_working_article

2018-10-11
  - 18면 전면광고 시 면머리 교쳬
  
   
2018-10-9
  - fix issue page view grouping from page_range to section_name based
  - fix story assignment
    - based on group, not page
    - return to story group with session saved into
    - add change story to working article
    - show working_article with story with different color in story assignment

2018-10-8
  - fix editorial_with_profile_image so that it can also be on any page, not just 23
  - change personal_image to has_profile_image:boolean
    this should tell whether or not to place person image

2018-10-6
  - add 6 column editorial
  - add 2 column opinion

2018-10-5
  - fix change_page_template
    - fix new attribute
    - let page refresh with generate_pdf_with_time_stamp

2018-10-3
  - assing story to working_article
  - add Sidekick
  - add issue story menu
  
2018-10-2
  - add datatable 
    - for story view

  - fix mobile preview xml merge
  - add article number to page svg
  - add story in menu

2018-9-30
  - fix edit color_page
  - upload page_heading image for first_page
  
2018-9-29
  - add Story model
  - in seed
    - add reporters as User 
    - do not regenerate working_article pdf unles when it is missing



2018_9_26
  - page_plan view with two pairing column
  - mobile xml preview merge
  - image crop with zoom and shifting
  - use ActiveStorage
  - use RSpec features spec
  - connect with naeil_cms

2018_9_25
  add extra fields to model, in order to avoid fetching parent models, so not to do n+1 fetching
  - page
      add_column :pages, :publication_id, :integer
      add_column :pages, :path, :string
      add_column :pages, :date, :date
      add_column :pages, :grid_width, :float
      add_column :pages, :grid_height, :float
      add_column :pages, :lines_per_grid, :float
      add_column :pages, :width, :float
      add_column :pages, :height, :float
      add_column :pages, :left_margin, :float
      add_column :pages, :top_margin, :float
      add_column :pages, :right_margin, :float
      add_column :pages, :bottom_margin, :float
      add_column :pages, :gutter, :float
      add_column :pages, :article_line_thickness, :float

  - section
      add_column :sections, :path, :string
      add_column :sections, :grid_width, :float
      add_column :sections, :grid_height, :float
      add_column :sections, :lines_per_grid, :float
      add_column :sections, :width, :float
      add_column :sections, :height, :float
      add_column :sections, :left_margin, :float
      add_column :sections, :top_margin, :float
      add_column :sections, :right_margin, :float
      add_column :sections, :bottom_margin, :float
      add_column :sections, :gutter, :float
      add_column :sections, :page_heading_margin_in_lines, :integer
      add_column :sections, :article_line_thickness, :float

  - article
      add_column :articles, :publication_name, :string
      add_column :articles, :path, :string
      add_column :articles, :page_heading_margin_in_lines, :integer
      add_column :articles, :grid_width, :float
      add_column :articles, :grid_height, :float
      add_column :articles, :gutter, :float

  - working_article
      add_column :working_articles, :publication_name, :string
      add_column :working_articles, :path, :string
      add_column :working_articles, :date, :date
      add_column :working_articles, :page_number, :integer
      add_column :working_articles, :page_heading_margin_in_lines, :integer
      add_column :working_articles, :grid_width, :float
      add_column :working_articles, :grid_height, :float
      add_column :working_articles, :gutter, :float

  - ad_box 
      add_column :ad_boxes, :path, :string
      add_column :ad_boxes, :date, :date
      add_column :ad_boxes, :page_heading_margin_in_lines, :integer
      add_column :ad_boxes, :page_number, :integer
      add_column :ad_boxes, :grid_width, :float
      add_column :ad_boxes, :grid_height, :float
      add_column :ad_boxes, :gutter, :float


2018_9_20

  - edit page_heading_text
  - put underline in page_heading_text
  - issue page_plan

  - change UI
  - Image Trimming
  - multiple image upload in one article

  - fix ad_group_oages
  - put ENV for sending FTP and print PDF

  - allow title and subtle with break at return

  - send PDF to Dropbox when pdf is send to Printer

  - save mobile xml

2018_9_19
  - update_working_articles
      generate_pdf or copy  after create
      generate page_pdf, refresh web page

  - Add Spread Model
    - issue view
    - spread_page_heading

2018_9_17
  - fix holyday
  - fix copy_heading in page.rb
  - replace mobile_xml_partials

2018_9_14
  - add rake tasl set_color_page
  - fix sending color page to print
  - fix sending color page to for ebiz

2018_9_13
  - page_plan
    - add more ad names
    - for page template display only temolates with same ad_type

2018_9_12
  - page 마감
    - add it to Dropbox with version number
    - add poof_version
    - add print_count
  - Print Monitoring
  - edit page_plan
    - pair_page
    - 광고주

  - when page template changed to full page ad page_heading text should changed to 

2018_9_12
  - fix page slug
      add page_number when creating page in issue
  - fix ad_box no line around
  - fix article no_top line


2018_9_3
  - 이미지 문페
  - 특집 박스조판
    - 외교국제
    - 기획
    - 도서

2018_9_2
  - 오늘 사용 광고 올리기
  - 오늘 사용 광고 라이브러리에 저장하기
  - 광고 저장된 광고 오늘 광고로 사용하기

  - change AdImageUploader to AdBoxImageUploader
      ad_image and ad_box for the current issue
      store it at publication/1/issue/ad/
      9-0_company_date.pdf
      9-0_samsung_2018-9-2.pdf
      parse file name and create ad_box and ad_image
  - create AdImageUploader
      ad_image for the publication
      store it at publication/ad/
      company_date.pdf
      samsung_2018-9-2.pdf

      parse file name and create ad_image

2018_8_31
  - fix line_space of subtitle after two lines

2018_8_28
  - add color field to ad_box table
  - add color field to ad_image table
  - remove
  #  page_number    :integer
  #  article_number :integer


2018_8_23
  - fix working_article to edit top_story fieid
  - fix page 10 template 2
  - fix crashing when image size is larger than article box

2018_8_20

  - fix single line body indent and text_alignment
  - use page_heading title from issue_plan
    - section grouping using page_heading

  - ad image, ad auto place
  - postgres db backup
  - ad auto placement
  - save ad data

2018_8_18
  - CMYK not for eps, pdf
  - fix page_heading section grouping

  - assign_reporters to working_article

2018_8_8

2018_8_2
  - display overflowing article box with red_line
  - prevent from sending to printer, if page has an overflowing article
  - give edit privilege only to certain user   

  - ad upload
  - ad auto placement at certain time

  - cms reporter page leader summit

2018_7_26
  - split_article
  - add PageSplitable, SectionSplitable, ArticleSplitable
  - add layout field to working_articles db

2018_7_24
  - fix working_article when kins =='사진'
    - show should have image info edit
    - generate article pdf when image is updated
    - remove link to image_edit when in 사진 모드
    - call generate_pdf_with_time_stamp when updating image with working_article_id

2018_7_20
  - friendly_id

2018_7_19
  - add whenever
  - add holidays.yml
  - fix sending pdf to printer to handle revisions

2018_7_16
  - fix page update_working_articles for extended_line_count and pushed_line_count

2018_7_13
  - new issue
    - validates uniqueness of issue.date
    - show previous_date
    - fix extended_line_count to template
      - new migrate add field to article
          add extended_line_count :integer
          add pushed_line_count   :integer
      - fix update working_article in page

    - rake new_issue
      - holidays.yml
          2018-1-1
          2018-3-1
          2018-8-15
          2018-10-10

2018_7_12
  - fix extended_line_count to increase relative to current value

2018_7_5
  - Ad db
      - upload ad with page_number
      - input advertiser, ad_type
  - db backup
  - print status
  - lock finished issues
  - pretty_url
  - sending revised pdf version to printer with different name


2018_7_2
  - when body text is one line, no first line indent applies
  - double quote at line ending bug
  - when sending pdf to print, make different named file

2018_7_1
  - no top line on working_article other than 22, 23
    - custom stroke_sides
  - image at the bottom position with article bottom_margin

2018_6_21
  - wire_story
    send_date
    content_id
    category_code
    category_name
    region_code
    region_name
    credit
    source
    title
    body

  - wire_image

2018_6_10
  - fix euc-kr bug
  - fix article initial kind as '기사'

2018_6_8
  - add char_count to article and working_article
  - show char_count in SVG
  - add smart quote filter to quote text

2018_6_7
  - fix ad_box to apply time_stamp
  - add scrape_gw

2018_6_6
  - fuzzy find ransack for opinion and profile
  - frendly_url

2018_6_5
  - Date.strftime("%d%m%y")
  - fix generate_layout for opinion
  - add opinion_jpg_image
  - add profile_jpg_image
  - add name= for opinion name

  newsman
  - align left overflow text
  - forbidden_first_chars
  - forbidden_last_chars
  - fix underflow text line count with news_image at page 22 order 2

2018_5_28
  - set '기사' as default working_article kind
  - fix delete_old_files for time_stamp
  - make high resolution jpg preview
  - add sending print files to dong_a and jung_ang

2018_5_26
  - add image_box menu on working_article
    - 1x1, 2x2, 3x3, 4x4,
    - top_right, top_left, top_center
    - middle_left, midle_center, middle_right
    - bottom_left, bottom_center, bottom_right

  - in the image panel
    - zoom_10%
    - zoom_20%
    - zoom_30%
    - move_right_10&
    - move_left_10&

2018_5_25
  - fix seven_column, six_column scope pg error

2018_5_23
  - add same_group_pages to page
  - redesign UI

2018_5_21
  - add same_group_pages to page

2018_5_21
  - add category_code to profile

2018_5_17
    - add category_code to working_article, reporter_group, opinion_writer
    - generate_pdf with time_stamp to force page reloading
    - article without page heading space or exteneded_line space
    - web scrape issue_plan

2018_5_10
  - add draw_divider to section
  - fix section config to save draw_divider
  - fix section.csv put page_number at first column
  - add botomm_box? to article and save botomm_box in layout_rb

2018_5_10
  - no subtile in editorial article
  - subject_head_s

2018_5_8
  - eager loading
  - run pg in production
  - add send pdf for proof reading
  - create xml

2018_5_7
  - handle forbidden at the beginning characters. . , ! ?
    - fix align token at the last line
  - chosun font not copying in PDF
    - make new font as Shinmoon.ttf

2018_5_5
  - change page to full page ad page with heading as 전면광고
  - add order field to AdBox

2018_5_4
  - move ad_image to ad_box, get rid of ad_image model
  - fix ad_image upload
  - add save_story_xml
  - remove image and ad_image from navigation bar menu
  - add pdf to ad_image uploader type
  - add previous issue_number to new issue

  - change sqlite to pg
  - eager loading


2018_5_3
  - save character_count_data
  - fix text_style, so that designers can edit

2018_5_1
  - add bottom_article?(article) method to Page
  - draw bottom_line only when draw_bottom_line and bottom_article is true
  - upload opinion_image
    - download csv
  - upload profile_image
    - download csv

2018_4_29
  - when we create new issue, make sure section pdf is generated only once
  - show quote_box_size
  - install postgres
  - opinion image uploaded
  - profile image uploaded

2018_4_26
  - place fixed ad in Section

2018_4_25
  - opinion image uploaded
    download csv
  - reporter similar to opinion
    download csv
  - fix ad image upload
    - handle EPS upload without imagemagick

2018_4_23
  - opinion image image_fit_to to horizontal

2018_4_22
  - fix image fit_type for opinion image to IMAGE_FIT_TYPE_KEEP_RATIO
  - show message after line change, quote_box size change, swap
2018_4_21
  - show character_count for working_article
  - add - extended_line_count, pushed

2018_4_20
  - fix overflow text
  - fix bug when changing template with extended lines not clearing
  - extended, pushed
  - fix reduced, and pulled

2018_4_19
  - 전면광고 page_heading
  - opinion
    - quote_auto

  - editorial
    - box show overflow
    - line above text
  - update section_config
    draw_divider: true for page 22

2018_4_18
  - fix ad page_heading_margin_in_lines
  - change black color as cmyk color  
  - add quote_box_size field to db
  - quote_box
    - 자동생성
    - ----
    - 2x2
    - 2x3
    - 2x4
    - ----
    - 발문 삭제

    - top_margin    = 2 lines
    - bottom_margin = 2 lines
  - fix save pdf for print

2018_4_17

2018_4_17
  - fix overflow text
  - add quote_box for opinion
    - add quote_bpx
    - remove quote_box
    - space only line for <br>?

2018_4_16
  - add zoom_preview
  - extended_line_count, pushed_line_count
  - swap story

2018_4_12
  - opinion_page
    - create overflow column
  - opinion_page with image

2018_4_11
  - fix page_heading
  - fix opinion add new generate rb

  - 발문 추가
  - 이미지 추가, adjust image to fit
  - size grow + 1, + 2, +3

  - row col for small screen for page view
  - fix 금칙 , . at begging of the line
  - 본문정리
    convert single line text to ##

2018_4_11
  - remove upload image to issue area from publication area

2018_4_9
  - change section#layout to Array
    - [0,0,3,3,'광고_5단통']
    - [0,0,3,3,'사설']
    - [0,0,3,3,'가고']
    - [0,0,3,3,'사진']

  - remove sample ad images from git repo
  - add imagemagick with brew

  - fix editorial title error
  - fix error when creating Article PDF

2018_4_6
  - fix editorial box bottom_line
    - editorial box personal profile and body line mismatch

  - s = body.gsub(/^\^/, "")
  - s = body.gsub(/(\n|\r\n)+/, "\n\n")

  - in seed file add text_style.yml copy to shared location
    - add text_style.yml to publication
  - add body menu in working_article auto paragraph to markdown convert, put extra empty line.
  - add default full page ad to new issue

  - 교정용(by second) by article
  - 인쇄용(by date)

2018_4_4
  - fix ## space above
  - add <br/> support
  - fix editorial margin

  - add save to Dropbox
  - place default ad
  - show menu by login role
  - adjust_size 크기_조절
  - adjust_body_size
  - copy_fit   욱여넣기


2018_4_3
  - remove c.md, remove unused filed up section template
  - extra line line for ##

2018_4_1

  - used style checking

  - 22, 기고 사진박스
    기본광고 자동 자동추가
    사진박스 올리기
    pdf file

  - 23, 내일시론 기자명
    기본광고 자동추가

  - - partial for opinion, editorial

  - add users to seed


2018_3_27
  - add Users with working section info
  - show section range
  - add space before for ## , fix bug at the last line
  - create default_issue and copy it when creating new issue
  - move default_issue_plan to publication/default_issue_plan.rb and and include it to git

2018_3_24
  - add tab on working_articles
    text-editor ace
    preview     annotatejs
    image_edit
    quote_box
    box_style

2018_3_21
  - add save_as_default in Page
  - fix bug when changing page template
    add profile and section_id
  - login window as root
  - make three navigation buttons
  - view page
  - heading erb
  - change heading/output.pdf to layout.pdf

2018_3_19
  - create non-publishing holidays
    issue_number generated according to holidays
    year date

2018_3_16
  - change output.pdf to story.pdf
2018_3_15
  - when creating new issue, copy page pdf and jpg
  - generate page heading with new data and issue number
  - we might need date to issue number table

2018_3_14
  - issue_info_for_cms => issue_info
  - add publication
  - navigation arrows
    - pre, up, next for page and article
  - for page 22, 23 don't show page template

2018_2_25
  - ## put space_before

2018_2_23
  - add search for OpinionWriter
    - use ransack
  - upload image to OpinionWriter
  - multiple image path extension support {eps, pdf, jpg}

2018_2_19
  - fix navbar, color, remove items
  - fix col-md-4 to handle col-sm-4
  - apply newly defined text_styles
  - add text_styles emphasis definition
        style, font, prefix, suffix, color, size

  - add opinion_writers CRUD

2018_2_19
  - auto-generate opinion writers profile

2018_2_14
  - add ReporterGroups table
  - add Reporters table
  - add ArticlePlan table

  - parse reporter_data.csv
  - add page_plan_show as assign_reporter

  - in PagePlan create_article_plans
        is not creating ArticlePlans
  - Article add word_count
      page_columns, column, row, front_page, top_story,s top_position, on_left_edge, on_right_edge

2018_2_13
  - add assign_reporter

2018_2_4
  - copy to or save to Sites/naeil/#{issue}/#{page} folder
  - when generating pdf save_layout unless File.exit?(layout_rb)

2018_1_18
  - story_assign
  - show article order in page view

2018_1_2
  - <br> support
  - ## support running_head
  - "◆ 보유세 카드 떠오르는 배경 =" with *my content*
  - strong emphasis support with **my content**
  - This is a
    line break.
  - support different title_main for page column and column
  - support different title for page column and column
  - section 22,23, and book review page heading
    - SVG to rlayout
    - Do not copy from template, generate it from Model  
  -  Do not save Article sample, just generate pdf, jpg
    - reduce installation size
  - install demo site, installation instruction
  - recovery scenario
  - 메인기사 선택 selection

2017_12_12
  - draw guide lines on top of page or top of article
  - set main article with selection  메인, 기사,
  - ignore orphan strategy, just truncate as it comes.
  - selectable main_article,
  - support editorial_title
  - support opinion_title

2017_12_10
  - rake update_text_style
  - install chosun and co-pub font at server
  - bold and ## markup support in news_article body
  - yaml_dump

2017_12_9
  - PageHeading bg uploading
  - add working_article locking and unlocking
    - add locked_by: user_id
  - increase_title_size_by:flaot
  - force_fit_title

2017_12_7
  - publication sample page with lines,
  -  fix Line Object
  - add 5 column page

2017_11_22
  - add browser gem to detect agent

2017_11_22
  - page_heading height
    front page, inner_page, opinion_page

2017_11_15
  - front page heading bg
  - image frame control

2017_11_14
  - change front page heading background
  - make front page heading background
  - upload front page heading ad

2017_11_13
  - NewsAdBox view
  - add image delete button

2017_11_11
  - NewsAdBox

2017_11_9
  - new table stroke_style
    - class_name
    - korean_name
    - stroke_yml

  - create stroke_style.yml to publication/style/text_style.yml
      - page_heading_margin_in_lines: [4,3]

      - news_article_box
          korean: 기사박스
          graphic: [0,0,0,1,0.3] #[left,top, right, bottom, thickness, color, type]
          news_heading:
          news_image:
            image: [0,0,0,1,0.3]
          quote
      - news_opinion_box
          korean: 오피니언박스
          graphic: [0,2,0,1,0.3]
      - news_editorial_box
          korean: 사설박스
          graphic: [1,6,1,1,0.3]
      - news_image_box
          korean: 이미지박스
          graphic: [1,6,1,1,6]
      - news_ad_box
          korean: 광고박스
          graphic: [1,1,1,1,0]
      - add eNews rethinking newspaper media
          - animated headline
          - reading text to speech


2017_11_30

2017_11_30
  - add news_view
    slid show of pages
    when clincked zoom in for article preview

2017_11_29
  - add opinion_writers
    - name
    - title
    - organization
    - position

2017_11_24
  - clone_page   별판생성
    add  clone_name to page

2017_11_28
  - upload bg_image for heading
  - create for guest_writer

2017_11_23
  - add zoom article view

2017_11_22
  - add different height for opinion page heading height

2017_11_9
  - 제목 3단 should have have space_before of 1 line, but it doesn't
  - file upload PDF rmagick can not render PDF for thumbnail
  - EPS support

2017_10_31
  create
    NewsBox < Container
    NewsArticleBox  < NewsBox
    NewsImageBox    < NewsBox
    NewsComicBox    < NewsBox
    NewsAdBox       < NewsBox

  handle bottom position
    draw line?
    leave a space at the bottom?

2017_10_23
  박스사진
    박스사진 하단 2행 여백 줄
    그램에만 테두리
    맨 윗줄이 아닐경우 위에 1행 여백
    left_edge, right_edge 적용

  만평
    만평은 테두리 있고/없고 0.3포인트
    만평 타이들로고
    작가이름(본문기자 이름 스타일 사용)
    left_edge, right_edge 적용

  판권 박스
    left_edge, right_edge 적용 없음

2017_10_18
  - 상단여백 1줄,  when v_position == center or bottom

2017_10_17
  - 사진위치 변경
    - 우쯕상단, 중간상당, ...
    - 하단 여백 적용

  - 그래픽 첨부
  - 부제 줄바꾸기 지원
  - 돌출광고
  - 제목 부제 사이즈 조절

2017_10_16
  - working article article kind tab or pill

2017_10_15
  - eNews
    search
    view page
    download pdf article
    download image from pdf article

2017_10_15
  - page reload for working_article
  - page reload for page

2017_10_7
    제목입력박스
      제목        # 여기제목                  
      부제목      ##
      문패       ###
      리딩       ####

    본문입력박스
      본문
      본문고딕    **내용**
      기자명      >
      관련기사    [관련기사 2면]

      테두리제목   #
      편집자주    ##
      중간제목    ###
      안내박스    ####

    발문입력박스(floating text_box)
      제목      #
      제목      ##
      발문      ###
      본문      

    사진_박스(floating text_box)
      사진설명제목  #
      사진설명     ##
      출처        ###

2017_10_7
    기사, 기고, 사설, 이미지_박스, 디자인박스

2017_10_7
  ## graphic_request #그래픽
    date              # 일시
    title             # 내용
    requester         # 의뢰자
    person_in_charge  # 작업자
    status            # 진행중, 완성
    description       # 비고

2017_10_7
  - add inactive field to WorkingArticle
    - this will allow us to keep unused articles as inactive, between template change.
  - add article_id to WorkingArticle
2017_10_7
  - fix switching page templates,
    - page_view_show
      - change_template_page_path
    - delete unused ad_boxes
    - show progress

  - add Trix WYSIWIG editor
    fix story.md to story.yml

    - 본문 중간제목 별도의 스타일
        앞 1 줄 적용
    - 본문 고딕은 inline emphasis 적용 **내용** to mean 본문고딕
    - fix pillar_layout text_style preview with our text system

  - editors note, 문패

2017_9_27
  - apply scale to text
  - apply custom text to body, caption, and title
  - create SectionHeading
  - SectionHeading.update_section_configs



2017_9_26
  - apply text_style from saved custom setting
  - subtitle apply new line with return key
  - fist page heading ad upload
      t.integer :page_id
      t.string :heading_ad
      mount_uploader :heading_ad, HeadingAdUploader
  - apply new page heading with AI file
  - fix title width with non-edge box

2017_9_25
  - redirect_to to page after uploading ad_image
    placed images are lost during switching page
  - trigger relayout of AdBox, and Page when uploading ad_image
  - fix bug in subtile bottom space
  - ad_box go_back button should link to page

2017_9_4
  - fix copy_section_template to page
      - not to delete the whole thing, but copy layout , config,
      - backup story files for difference story_number templates
  - make story_backup_folder on each page folder

  - add table, graphic
  - change section_pdf to section

2017_9_4
  - make page with SVG, and get rid of title links
  - paragraph input with single return

  - upload ad in AdBox, add upload in WorkingArticle
  - page_headings
  - batch place issue_images
  - batch place, issue_ads
  - fix it so for image position change
  - image zoom and pan

2017_9_1
  - replace all text with TtitleText
  - carrierwave thumbnail
      - set image directory
      - small image 100x100
      - place images with Flexbox
  - squeeze title
    - auto adjust overflowing title

2017_8_28
  - image caption
  - add source box to image edit
  - allow adjusting image size

2017_8_23
  - ad_width, ad_x, ad left_inset, right_inset

2017_8_22
  - fix issue_images
    - from issue_images link to edit , not show
    - delete image
      - return to issue_images after delete
    - color green, if placed_in_layout red if not
    - 기사창으로 이동, if placed_in_layout
    - return from image edit,
      to issue_image, if article is not assigned
      to article if assigned
  - working_article
      - show image, personal_image
      - add link to edit_image
  - fix issue_ad_images
  - fix x, width


2017_8_16
  - in article view add article type selection

  - pan_image
  - image_with_caption
  - title and subtitle squeeze to fit
  - make use custom paragraph for title, subtitle, and all other text.

2017_8_11
  - news issue

2017_8_9
  - 사진 및 부분 2행

  - width of image with gutter

  - 문패
    문패 : subject_head #
    두덩어리 문패

    사설항목
    사설제목
    기고제목

    editorial_head
    문패 : subject_head #
    사설항목: editorial_head #
    {종류: '기고'}
    {종류: '사설'} ,

  [0,1,4,3, {광고: '5단통'}]
  기사입력창에서 수정

    {종류: '사진'}
    {종류: '기고'}
    {종류: '사설'}

기사입력창에서 수정

2017_8_8
  - change issue_path_with_date, from id
  - page-plan switching page
    - fix ad_box not copying bug
  - smart quote

  - article_kind

  - create new issue

  - image_caption, image_title, image_pan,
    - image_upload
    - ad_upload
    - 사진 위치 bug
    - upload image


  - box style support
    border, bgcolor, grid_frame

  - new publication at 3002
    - banner_image

2017_8_3
  - spinning progress-bar while processing


2017-8-1
  - add article kind 'story', 'editorial'
  - add category heading, body, float

  - sinlge and double quote error in input box,
  - smart quote
  - add box_attributes
  - add unit in publication
  - draw_sides,
  - article_bottom_spaces_in_lines
  - draw_divider

2017-7-28
  - front_page_heading_height
  - inner_page_heading_height
  - article_bottom_spaces_in_lines
  - article_line_draw_sides
      bottom_full, bottom_columns, dividing_vertical
  - article_line_thickness
  - on_left_edge, on_right_edge

2017-7-26
  - save publication info
    /SoftwareLab/newsman/publication_name/text_style.yml
    /SoftwareLab/newsman/publication_name/publication_info.yml

2017-7-21
  - front page page_heading,
  - auto generate issue date
  - fix change page bug, delete previous article files

2017-7-17
  - add color
  - fix page update after article edit
  - fix page update after article edit

2017-7-14
  - add status to page_plan
    indication page updated status
    add button to update individual page

2017-7-13
  - create dynamic text_style definition for varying text_style
    give, col, row,
    {
      '1x3': 12,
      '2x3': 14,
      '4x15': 16,
      '5x15': 16,
      '6x15': 18,
    }

2017-7-13
  - t.text :box_attributes
  - t.string :graphic_attributes

  - t.string :markup
  - category heading 제목박스, body 본문, float 플롯트

2017-7-9
  - add markup
  - used in column
    subject_head_4_5_6
    subtitle_4_5_6
    subtitle_3
    subtitle_2
    subtitle_1

2017-7-7
  - add units in publication
    mm, inch, point

  - add 문페, 편집자_노트
    cation, caption_title

2017-7-6
  - fix Article, and WorkingArticle to use custom style by sending newsman article . -custom={publication.name}

2017-7-3
  - fix rlayout create_columns

2017-7-2
  - fix article and working_article gutter, left_margin, right_margin depending on the position
    - add on_left_edge
    - add on_right_edge

3017-7-1
  - save text_style_file at "/Users/Shared/SoftwareLab/newspaper/publication_name.yml"
  - add regenerate Section with custom style, so we can see the change taking effect.
  - save_current_text_styles

  - update how NewspaperSectionPage lays out article column width depending on the location and width

3017-6-29
  - add issue_plan to issue
  - create page_plan table
    - page_number
    - section_name
    - profile
    - column
    - row
    - story_count
    - ad_type
    - advertiser
    - color_page
    - issue_id

    - update paired color_page
  - default_issue_plan should have have just page_number and profile
  - we should parse it and fill in the information from it

3017-6-28
  - fix parsing issue plan error
  - treat ads similar to images, attaching it to working_article_box
  - parse_ad_images
  - add devise

  - fix left_margin, right_margin for NewsArticleBox column
    - left_margin should be 0 for first column
    - right_margin should be 0 for right most column

  - fix page_headings


2017-6-27
  - rename ad_image to ad_image
  - fix ad rlayout_rb as NewsAdBox < Container
  - create AdBox


2017-6-23
  - rename ad_image to ad_image
  - fix ad containing section, working_article
  - create working_article_box for ads

2017-6-22
  - make rails project portable
    - gitignore public/issue/*
    - rake regenerate setup
    - db:drop db:seed
  - use drop box for image, graphic and ads

2017-6-21
  - issue_plan
    면배열표
      date
      publication_id

  - page_plan
    issue_plan_id
    ad_type
    advertiser
    text_color
    article_count
    page_number
    template_id


2017-6-19
  - merge TexgStyle show and edit when layout is shown
  단락 스타일, 영문 단락 스타일
    no space in the name
    no 's in the name
    no - in the joining
    _ 통일 cross_head
  - running_head?, cross_head
  - editor's note  , editor_note
  - brand naming, 애드-브랜드명
  - 왼쪽, 오른쪽, 가운데, 양측정렬
  - add box_attributes to text_style
  - 그래픽 효과?, 단락 장식, 박스_디자인
  {fill_color: 'red', stroke_width: '1', stroke_color: 'pink', stroke_dash: [1,2,1,2]}
  - add 문패 sample
  - two subject_head_18, subject_head_14, subject_head_12
  - 문페 18, 14, 12

  - 5,6,7단 부터 문패18
  - 3,4단 부터 14
  - 2단 12
  - ## 본문고딕
  - ### 박스단락

2017-6-12
  - apply image to Article
      - regenerate articles
      - mark it as used_in_layout: true
      - regenerate pages
  - image_caption
  - image_frame 0.1
    - wrap frame line on image only
  - image upload
  - make title & subtitle size adjustable
  - image_file_name
    - add date
  - ad space above ad box
    - 1 line
  - {종류: '만평'}
  - section index sort by page and ad

2017-6-15
  - add ad_images

2017-6-8
  - name images with page-order-column_size.jpg
  - parse image
      1-1-2.jpg, 2-1-3.jpg,
  - add_image in controller
  - add_image view
  - add fields to image model
      t.integer :page_number
      t.integer :story_number
      t.boolean :landscape
      t.integer :issue_id
      t.integer :working_article_id

2017-6-7
  - custom CUSTOM_NEWSPAPER_STYLE


"CMYK=100,70,0,0,0"
"RGB=100,100,100,50"

black
white
yellow
cyan
magenta

#ffeedd

123456789abcdef

2017-6_7
  - image_template sample duplicate

2017-6_5
  - put buttons in single line
    - change button_to to link_to single line
    - class: "btn-group  btn-group-sm btn-warning"

  - new route
    - style_view
    - style_update

2017-6_2
  - font style
  -   tracking    = point
  -   scale       = 100%
  -   space_width = point

  - preload images in folder
  - image box
  - image resource folder
  - 통합데스트 대체 UI
    - file name convention, folder
    - change height_extra_line to extra_height_in_lines

2017-6_1
  - 광고 크기조절 내부 여백 줄이 보일 수 있도록
  - 광고 겹치는 부분 프롯으로 처리하기(overlapping_floats)
  - image size by grid_x, and lines for height
      3x2+3
  - has_many images
  - has_many overlapping_floats
  - has_many personal_images
  - has_many quotes

2017-5_30
  - fill_up_empty_lines

  - create filler_text for 6 page_columns

2017-5_29
  - save article_type
  - creating working_article
    - parse_story


2017-5_28
  - add show issue to show 24 pages
  - add show page



2017-5_25
  - add issue
  - add page



2017-5_25
  - add ad_type to section_config_hash

2017-5_24
  - heading image fit type no scale
  - front_page title 3 lines
  - front_page main 3 lines top position 3 lines


2017-5_20
  - show overflowing text
  - do reporter markup
      What if we can place reporter line in the middle of the empty space.
  - create add when parsing layout


2017-5-19
  - article
    NEWS_ARTICLE_FRONT_PAGE_EXTRA_HEADING_SPACE_IN_LINES = 1



  - section
    - copy ad template
    - fix ad name with space

    - display thumbnail view of SVG
    - SVG with victor gem
    - ad input not reflecting when parsing layout
    - profile not updating after first time.



2017-5-16

  - text_style view  
    title two lines
    subtitle two lines


  - section
    - make section path
      page/profile/order
    - section clone button
    - parse section csv

2017-5-15
  - body text too tight
  - fix text_area text size to 16
  - make all articles editable

  - page_header
  - add parsing picture type to  section layout


  - save layout as file name, unique identifier
    - profile/layout

2017-5-14
  - fix top_position not being reflecting error
  - draw bottom line without gap
  - fix single column article width error
  - 2 lines subtitle space after
  - puts tracking to body


2017-5-12
  - paper size
  - text_line_spacing, 행간
  - add text_style scale 장평
  - fix squeezing effect of article

2017-5-10
  - spacing
    - 2 lines at the bottom, one line at the top
  - line thickness , 0.3
  - tracking for body
  - add top_story, for first page, so we have 4 kinds, 0,1,2,3
  - 0 : middle articles
  - 1 : top_position articles
  - 2 : top_story top_position articles
  - 3 : top_story for first page articles

  - add constants
    - NEWS_ARTICLE_BOTTOM_SPACE_INLINES   = 2
    - NEWS_ARTICLE_TOP_LINE_SPACE         = 1
    - NEWS_ARTICLE_INE_THICKNESS          = 0.3
    - GRID_LINE_COUNT                     = 7

2017-5-10
  - add top_position field to indicate the article is at y==0
  - article templates are grouped into 3 kinds
    0: regular, 1: top_box, 2: top_stroy,
  - copy_articles
    - copy_page_head
    - fix NewSectionPage to merge page_heading

2017-5-4
  - top_story
    - selectable column width subtitle layout
    -
  - text_style preview with sample text

2017-5-3
  - add more fields in text_styles
    - add font
    - add text_line_spacing

2017-5-1
  - add image in Article
    - add_image, add_personal_image, add_quote
    - add_select_image
    - article with image preview in SVG

2017-4-20
  - fix section parse bug
  - add download_csv for text_styles, ad, section
  - generate more article samples
  - add page_columns to article
  - generate article samples for each page_columns, 7, 6

  - add more section samples in seed file.
  - calculate number of words or char or lines.
  - use difference font
  - add article editing

2017-4-28
  - add image_templates
  - parent_column
  parent_column
  - direction
  - size

  - column
  - lines
  - make subtile as text_area for line braking


2017-4-27
  - font leading value for title, subtile
  - ad for 7.5
  - bridge 14
  - add Image table
    - file_name,

2017-4-24
  - install Yoon font to server
  - add ace-rails
  - add kaminari
  - add carrierwawe

2017-4-19
  - add ad menu
  - validates presence of name, column, row, page_columns in section
  - validates presence of column, row , layout, publication_id in section
  - validates uniqueness of layout in section
  - profile, is_front_page, is synthesized, do don't show at edit
  - fix copy_articles
  - fix going back in section show, edit according to the column list

  - download pdf, section
  - download pdf, article

2017-4-18
  - regenerate pdf when updating section
  - issue heading, page_heading_height = 3
  - article type:top_box top_box
  - change is_front_page to is_front_page
  - pagination
  - localization
  - add ad table
  - add issue table

- 2017-4-16
  - fix size mismatching bug on PDF
  - generate section pdf
  - sub-menubar

- 2017-4-15
  - generate more article sample 4,5,6 rows sample
  - display 4,5,6

- 2017-4-14
  - add section
    - save config
    - generate_pdf


  - add article by columnxrow folder

- 2017-3-24
  - title style doesn't change align left last paragraph line
  - ad top_story field to Article
  - add Article more sample
    0. default
    1. image
    2. quote
    3. personal_image
    4. top_story
