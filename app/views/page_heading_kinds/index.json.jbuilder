json.set! :data do
  json.array! @page_heading_kinds do |page_heading_kind|
    json.partial! 'page_heading_kinds/page_heading_kind', page_heading_kind: page_heading_kind
    json.url  "
              #{link_to 'Show', page_heading_kind }
              #{link_to 'Edit', edit_page_heading_kind_path(page_heading_kind)}
              #{link_to 'Destroy', page_heading_kind, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end