json.set! :data do
  json.array! @annotations do |annotation|
    json.partial! 'annotations/annotation', annotation: annotation
    json.url  "
              #{link_to 'Show', annotation }
              #{link_to 'Edit', edit_annotation_path(annotation)}
              #{link_to 'Destroy', annotation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end