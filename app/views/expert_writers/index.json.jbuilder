json.set! :data do
  json.array! @expert_writers do |expert_writer|
    json.partial! 'expert_writers/expert_writer', expert_writer: expert_writer
    json.url  "
              #{link_to 'Show', expert_writer }
              #{link_to 'Edit', edit_expert_writer_path(expert_writer)}
              #{link_to 'Destroy', expert_writer, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end