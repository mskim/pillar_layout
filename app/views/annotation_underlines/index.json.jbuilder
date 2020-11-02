json.set! :data do
  json.array! @annotation_underlines do |annotation_underline|
    json.partial! 'annotation_underlines/annotation_underline', annotation_underline: annotation_underline
    json.url  "
              #{link_to 'Show', annotation_underline }
              #{link_to 'Edit', edit_annotation_underline_path(annotation_underline)}
              #{link_to 'Destroy', annotation_underline, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end