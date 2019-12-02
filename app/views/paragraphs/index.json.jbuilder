json.set! :data do
  json.array! @paragraphs do |paragraph|
    json.partial! 'paragraphs/paragraph', paragraph: paragraph
    json.url  "
              #{link_to 'Show', paragraph }
              #{link_to 'Edit', edit_paragraph_path(paragraph)}
              #{link_to 'Destroy', paragraph, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end