json.set! :data do
  json.array! @annotation_circles do |annotation_circle|
    json.partial! 'annotation_circles/annotation_circle', annotation_circle: annotation_circle
    json.url  "
              #{link_to 'Show', annotation_circle }
              #{link_to 'Edit', edit_annotation_circle_path(annotation_circle)}
              #{link_to 'Destroy', annotation_circle, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end