json.extract! web_page, :id, :current_tool, :width, :height, :page_number, :toc, :text_content, :text_position, :issue_id, :created_at, :updated_at
json.url web_page_url(web_page, format: :json)
