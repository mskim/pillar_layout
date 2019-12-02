json.set! :data do
  json.array! @announcements do |announcement|
    json.partial! 'announcements/announcement', announcement: announcement
    json.url  "
              #{link_to 'Show', announcement }
              #{link_to 'Edit', edit_announcement_path(announcement)}
              #{link_to 'Destroy', announcement, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end