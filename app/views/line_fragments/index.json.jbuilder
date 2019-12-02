json.set! :data do
  json.array! @line_fragments do |line_fragment|
    json.partial! 'line_fragments/line_fragment', line_fragment: line_fragment
    json.url  "
              #{link_to 'Show', line_fragment }
              #{link_to 'Edit', edit_line_fragment_path(line_fragment)}
              #{link_to 'Destroy', line_fragment, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end