json.set! :data do
  json.array! @table_styles do |table_style|
    json.partial! 'table_styles/table_style', table_style: table_style
    json.url  "
              #{link_to 'Show', table_style }
              #{link_to 'Edit', edit_table_style_path(table_style)}
              #{link_to 'Destroy', table_style, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end