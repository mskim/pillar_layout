json.extract! profile, :id, :name, :profile_image, :work, :position, :email, :publication_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
