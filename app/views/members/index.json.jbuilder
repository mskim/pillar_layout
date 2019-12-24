json.set! :data do
  json.array! @members do |member|
    json.partial! 'members/member', member: member
    json.url  "
              #{link_to 'Show', member }
              #{link_to 'Edit', edit_member_path(member)}
              #{link_to 'Destroy', member, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end