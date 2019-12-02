json.set! :data do
  json.array! @yh_pictures do |yh_picture|
    json.partial! 'yh_pictures/yh_picture', yh_picture: yh_picture
    json.url  "
              #{link_to 'Show', yh_picture }
              #{link_to 'Edit', edit_yh_picture_path(yh_picture)}
              #{link_to 'Destroy', yh_picture, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end