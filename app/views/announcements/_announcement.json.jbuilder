json.extract! announcement, :id, :name, :kind, :title, :subtitle, :column, :lines, :page, :color, :script, :publication_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
