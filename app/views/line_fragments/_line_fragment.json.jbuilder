json.extract! line_fragment, :id, :working_article_id, :paragraph_id, :order, :column, :line_type, :x, :y, :width, :height, :tokens, :text_area_x, :text_area_width, :created_at, :updated_at
json.url line_fragment_url(line_fragment, format: :json)
