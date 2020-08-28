json.set! :data do
  json.array! @tables do |table|
    json.partial! 'tables/table', table: table
    json.url  "
              #{link_to 'Show', table }
              #{link_to 'Edit', edit_table_path(table)}
              #{link_to 'Destroy', table, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end