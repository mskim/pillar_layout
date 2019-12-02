json.extract! article, :id, :column, :row, :title, :subtitle, :body, :reporter, :has_profile_image, :image, :quote, :publication_id, :created_at, :updated_at
json.url article_url(article, format: :json)
