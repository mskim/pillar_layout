json.extract! wire_story, :id, :send_date, :content_id, :category_code, :category_name, :page_ref_code, :page_ref_name, :credit, :source, :title, :body, :issue_id, :created_at, :updated_at
json.url wire_story_url(wire_story, format: :json)
