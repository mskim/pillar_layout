json.set! :data do
  json.array! @pillars do |pillar|
    json.partial! 'pillars/pillar', pillar: pillar
    json.url  "
              #{link_to 'Show', pillar }
              #{link_to 'Edit', edit_pillar_path(pillar)}
              #{link_to 'Destroy', pillar, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end