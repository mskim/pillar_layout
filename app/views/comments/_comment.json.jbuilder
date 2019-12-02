json.extract! comment, :id, :name, :text, :image, :x_value, :y_value, :width, :height, :proof_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
