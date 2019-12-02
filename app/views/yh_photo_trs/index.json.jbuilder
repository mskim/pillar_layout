json.set! :data do
  json.array! @yh_photo_trs do |yh_photo_tr|
    json.partial! 'yh_photo_trs/yh_photo_tr', yh_photo_tr: yh_photo_tr
    json.url  "
              #{link_to 'Show', yh_photo_tr }
              #{link_to 'Edit', edit_yh_photo_tr_path(yh_photo_tr)}
              #{link_to 'Destroy', yh_photo_tr, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end