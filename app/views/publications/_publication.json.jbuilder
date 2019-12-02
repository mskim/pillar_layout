json.extract! publication, :id, :name, :paper_size, :width, :height, :left_margin, :top_margin, :right_margin, :bottom_margin, :lines_per_grid, :gutter, :page_count, :section_names, :page_columns, :created_at, :updated_at
json.url publication_url(publication, format: :json)
