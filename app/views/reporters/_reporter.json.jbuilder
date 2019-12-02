json.extract! reporter, :id, :name, :email, :title, :reporter_group_id, :created_at, :updated_at
json.url reporter_url(reporter, format: :json)
