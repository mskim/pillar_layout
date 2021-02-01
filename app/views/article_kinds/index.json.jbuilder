json.set! :data do
  json.array! @article_kinds do |article_kind|
    json.partial! 'article_kinds/article_kind', article_kind: article_kind
    json.url  "
              #{link_to 'Show', article_kind }
              #{link_to 'Edit', edit_article_kind_path(article_kind)}
              #{link_to 'Destroy', article_kind, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end