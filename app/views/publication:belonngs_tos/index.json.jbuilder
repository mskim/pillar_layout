json.set! :data do
  json.array! @publication:belonngs_tos do |publication:belonngs_to|
    json.partial! 'publication:belonngs_tos/publication:belonngs_to', publication:belonngs_to: publication:belonngs_to
    json.url  "
              #{link_to 'Show', publication:belonngs_to }
              #{link_to 'Edit', edit_publication:belonngs_to_path(publication:belonngs_to)}
              #{link_to 'Destroy', publication:belonngs_to, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end