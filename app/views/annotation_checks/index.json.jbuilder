json.set! :data do
  json.array! @annotation_checks do |annotation_check|
    json.partial! 'annotation_checks/annotation_check', annotation_check: annotation_check
    json.url  "
              #{link_to 'Show', annotation_check }
              #{link_to 'Edit', edit_annotation_check_path(annotation_check)}
              #{link_to 'Destroy', annotation_check, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end