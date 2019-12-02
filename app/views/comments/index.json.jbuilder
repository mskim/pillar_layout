json.set! :data do
  json.array! @comments do |comment|
    json.partial! 'comments/comment', comment: comment
    json.url  "
              #{link_to 'Show', comment }
              #{link_to 'Edit', edit_comment_path(comment)}
              #{link_to 'Destroy', comment, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end