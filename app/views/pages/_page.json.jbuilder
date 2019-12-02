json.extract! page, :id, :page_number, :section_name, :column, :row, :ad_type, :story_count, :color_page, :profile, :issue_id, :template_id, :created_at, :updated_at
json.url page_url(page, format: :json)
