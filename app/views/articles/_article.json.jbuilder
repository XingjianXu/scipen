json.extract! article, :id, :title, :slug, :content, :created_at, :updated_at
json.url article_url(article, format: :json)
