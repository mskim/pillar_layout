json.extract! section_heading, :id, :page_number, :section_name, :date, :layout, :publication_id, :created_at, :updated_at
json.url section_heading_url(section_heading, format: :json)
