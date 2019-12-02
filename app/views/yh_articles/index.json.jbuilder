json.set! :data do
  json.array! @yh_articles do |yh_article|
    json.partial! 'yh_articles/yh_article', yh_article: yh_article
    json.url  "
              #{link_to '보기', yh_article }
              #{link_to '수정', edit_yh_article_path(yh_article)}
              #{link_to '삭제', yh_article, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end