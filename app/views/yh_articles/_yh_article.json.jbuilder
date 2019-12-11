json.extract! yh_article, :id, :action, :service_type, :content_id, :date, :time, :urgency, :category, :class_code, :attriubute_code, :source, :credit, :region, :title, :body, :writer, :char_count, :taken_by, :created_at, :updated_at
json.url yh_article_url(yh_article, format: :json)
