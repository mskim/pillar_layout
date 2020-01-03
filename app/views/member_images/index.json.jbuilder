json.set! :data do
  json.array! @member_images do |member_image|
    json.partial! 'member_images/member_image', member_image: member_image
    json.url  "
              #{link_to 'Show', member_image }
              #{link_to 'Edit', edit_member_image_path(member_image)}
              #{link_to 'Destroy', member_image, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end