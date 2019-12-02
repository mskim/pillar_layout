json.set! :data do
  json.array! @reporter_graphics do |reporter_graphic|
    json.partial! 'reporter_graphics/reporter_graphic', reporter_graphic: reporter_graphic
    json.url  "
              #{link_to 'Show', reporter_graphic }
              #{link_to 'Edit', edit_reporter_graphic_path(reporter_graphic)}
              #{link_to 'Destroy', reporter_graphic, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end