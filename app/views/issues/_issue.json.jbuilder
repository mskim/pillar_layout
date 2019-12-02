json.extract! issue, :id, :date, :number, :plan, :publication_id, :created_at, :updated_at
json.url issue_url(issue, format: :json)
json.pages issue, :pages
