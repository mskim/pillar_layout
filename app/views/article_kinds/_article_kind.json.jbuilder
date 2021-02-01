json.extract! article_kind, :id, :publication_id, :name, :line_draw_sides, :input_fields, :bottoms_space_in_lines, :layout_erb, :created_at, :updated_at
json.url article_kind_url(article_kind, format: :json)
