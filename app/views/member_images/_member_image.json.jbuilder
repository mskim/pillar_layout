json.extract! member_image, :id, :title, :caption, :source, :order, :group_image_id, :created_at, :updated_at
json.url member_image_url(member_image, format: :json)
