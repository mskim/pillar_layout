json.extract! publication:belonngs_to, :id, :page_heading_kind, :page_type, :layout_erb, :height_in_lines, :bg_image, :created_at, :updated_at
json.url publication:belonngs_to_url(publication:belonngs_to, format: :json)
