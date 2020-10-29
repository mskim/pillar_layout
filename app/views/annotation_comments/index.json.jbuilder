json.set! :data do
  json.array! @annotation_comments do |annotation_comment|
    json.partial! 'annotation_comments/annotation_comment', annotation_comment: annotation_comment
    json.url  "
              #{link_to 'Show', annotation_comment }
              #{link_to 'Edit', edit_annotation_comment_path(annotation_comment)}
              #{link_to 'Destroy', annotation_comment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end