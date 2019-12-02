json.extract! ad_image, :id, :ad_type, :column, :row, :page_id, :created_at, :updated_at
json.url ad_image_url(ad_image, format: :json)
