json.set! :data do
  json.array! @body_lines do |body_line|
    json.partial! 'body_lines/body_line', body_line: body_line
    json.url  "
              #{link_to 'Show', body_line }
              #{link_to 'Edit', edit_body_line_path(body_line)}
              #{link_to 'Destroy', body_line, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end