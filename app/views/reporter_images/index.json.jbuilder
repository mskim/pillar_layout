json.set! :data do
  json.array! @reporter_images do |reporter_image|
    json.partial! 'reporter_images/reporter_image', reporter_image: reporter_image
    json.url  "
              #{link_to 'Show', reporter_image }
              #{link_to 'Edit', edit_reporter_graphic_path(reporter_image)}
              #{link_to 'Destroy', reporter_image, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end