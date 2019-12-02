json.extract! working_article, :id, :column, :row, :order, :profile, :title, :subtitle, :body, :reporter, :email, :has_profile_image, :image, :quote, :subject_head, :is_front_page, :top_story, :top_position, :page_id, :created_at, :updated_at
json.url working_article_url(working_article, format: :json)
