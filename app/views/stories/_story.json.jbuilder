json.extract! story, :id, :user_id, :working_article_id, :reporter, :group, :date, :title, :subtitle, :body, :quote, :status, :char_count, :published, :path, :created_at, :updated_at
json.url story_url(story, format: :json)
