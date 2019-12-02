json.extract! page_heading, :id, :page_number, :section_name, :date, :publication_id, :created_at, :updated_at
json.url page_heading_url(page_heading, format: :json)
