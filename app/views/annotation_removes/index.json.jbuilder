json.set! :data do
  json.array! @annotation_removes do |annotation_remove|
    json.partial! 'annotation_removes/annotation_remove', annotation_remove: annotation_remove
    json.url  "
              #{link_to 'Show', annotation_remove }
              #{link_to 'Edit', edit_annotation_remove_path(annotation_remove)}
              #{link_to 'Destroy', annotation_remove, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end