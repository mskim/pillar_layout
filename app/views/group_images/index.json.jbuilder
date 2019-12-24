json.set! :data do
  json.array! @group_images do |group_image|
    json.partial! 'group_images/group_image', group_image: group_image
    json.url  "
              #{link_to 'Show', group_image }
              #{link_to 'Edit', edit_group_image_path(group_image)}
              #{link_to 'Destroy', group_image, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end