json.set! :data do
  json.array! @yh_photo_fr_ynas do |yh_photo_fr_yna|
    json.partial! 'yh_photo_fr_ynas/yh_photo_fr_yna', yh_photo_fr_yna: yh_photo_fr_yna
    json.url  "
              #{link_to 'Show', yh_photo_fr_yna }
              #{link_to 'Edit', edit_yh_photo_fr_yna_path(yh_photo_fr_yna)}
              #{link_to 'Destroy', yh_photo_fr_yna, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end