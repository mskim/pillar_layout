json.set! :data do
  json.array! @yh_graphics do |yh_graphic|
    json.partial! 'yh_graphics/yh_graphic', yh_graphic: yh_graphic
    json.url  "
              #{link_to 'Show', yh_graphic }
              #{link_to 'Edit', edit_yh_graphic_path(yh_graphic)}
              #{link_to 'Destroy', yh_graphic, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end