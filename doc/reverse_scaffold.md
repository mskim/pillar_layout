# Reverse scaffold

rails generate scaffold AdBoxTemplate grid_x:integer grid_y:integer column:integer row:integer order:integer ad_type:string section:references --no-migration

rails generate scaffold AdBox grid_x:integer grid_y:integer column:integer row:integer ad_type:string advertiser:string inactive:boolean page:references --no-migration

rails generate scaffold AdImage ad_type:string column:integer row:integer ad_image:string advertiser:string page_number:integer article_number:integer ad_box:references issue:references used_in_layout:boolean --no-migration

rails generate scaffold Ad name:string column:integer row:integer page_columns:integer publication:references --no-migration


rails generate scaffold GraphicRequest date:date title:string requester:string person_in_charge:string status:string description:text --no-migration

rails generate scaffold HeadingAdImage heading_ad_image:string x:float y:float width:float height:float x_in_unit:float y_in_unit:float width_in_unit:float height_in_unit:float page_heading:references advertiser:string --no-migration

rails generate scaffold HeadingBgImage heading_bg_image:string page_heading:references --no-migration

rails generate scaffold Image column:integer row:integer extra_height_in_lines:integer image:string caption_title:string caption:string source:string position:integer page_number:integer story_number:integer landscape:boolean used_in_layout:boolean working_article:references issue:references --no-migration


rails generate scaffold OpinionWriter name:string title:string work:string position:string publication:references --no-migration

rails generate scaffold PageHeading page_number:integer section_name:string date:string layout:text page:references --no-migration

rails generate scaffold PagePlan page_number:integer section_name:string selected_template:references column:integer row:integer story_count:integer profile:string ad_type:string advertiser:string color_page:boolean dirty:boolean issue:references --no-migration


rails generate scaffold Post body:text email:string --no-migration

rails generate scaffold Publication name:string unit:string paper_size:string width_in_unit:float height_in_unit:float left_margin_in_unit:float top_margin_in_unit:float right_margin_in_unit:float bottom_margin_in_unit:float gutter_in_unit:float width:float height:float left_margin:float top_margin:float right_margin:float bottom_margin:float gutter:float lines_per_grid:integer page_count:integer section_names:text page_columns:text row:integer front_page_heading_height:integer inner_page_heading_height:integer article_bottom_spaces_in_lines:integer article_line_draw_sides:text article_line_thickness:float draw_divider:boolean --no-migration

rails generate scaffold SectionHeading page_number:integer section_name:string date:string layout:text publication:references --no-migration

rails generate scaffold Section profile:string column:integer row:integer order:integer ad_type:string is_front_page:boolean story_count:integer page_number:integer section_name:string color_page:boolean publication:references layout:text --no-migration

rails generate scaffold StrokeStyle klass:string name:string stroke:text publication:references --no-migration

rails generate scaffold TextStyle korean_name:string english:string category:string font_family:string font:string font_size:float text_color:string alignment:string tracking:float space_width:float scale:float text_line_spacing:float space_before_in_lines:integer space_after_in_lines:integer text_height_in_lines:integer box_attributes:text markup:string graphic_attributes:text publication:references --no-migration

rails generate scaffold User email:string encrypted_password:string reset_password_token:string reset_password_sent_at:datetime remember_created_at:datetime sign_in_count:integer current_sign_in_at:datetime last_sign_in_at:datetime current_sign_in_ip:string last_sign_in_ip:string name:string role:integer --no-migration

rails generate scaffold Issue date:date number:string plan:text publication:references --no-migration

rails generate scaffold Page page_number:integer section_name:string column:integer row:integer ad_type:string story_count:integer color_page:boolean profile:string issue:references page_plan:references template:references clone_name:string --no-migration

rails generate scaffold Article grid_x:integer grid_y:integer column:integer row:integer order:integer kind:string profile:integer title_head:string title:text subtitle:text subtitle_head:text body:text reporter:string email:string personal_image:string image:string quote:text subject_head:string on_left_edge:boolean on_right_edge:boolean is_front_page:boolean top_story:boolean top_position:boolean section:references --no-migration

rails generate scaffold WorkingArticle grid_x:integer grid_y:integer column:integer row:integer order:integer kind:string profile:string title:text title_head:string subtitle:text subtitle_head:string body:text reporter:string email:string personal_image:string image:string quote:text subject_head:string on_left_edge:boolean on_right_edge:boolean is_front_page:boolean top_story:boolean top_position:boolean inactive:boolean article:references page:references --no-migration
