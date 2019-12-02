json.set! :data do
  json.array! @graphic_requests do |graphic_request|
    json.partial! 'graphic_requests/graphic_request', graphic_request: graphic_request
    json.url  "
              #{link_to 'Show', graphic_request }
              #{link_to 'Edit', edit_graphic_request_path(graphic_request)}
              #{link_to 'Destroy', graphic_request, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end