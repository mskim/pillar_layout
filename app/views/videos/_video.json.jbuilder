json.extract! video, :id, :x, :y, :width, :height, :player_type, :source_video_url, :web_page_id, :created_at, :updated_at
json.url video_url(video, format: :json)
