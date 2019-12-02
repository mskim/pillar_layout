json.set! :data do
  json.array! @page_layouts do |page_layout|
    json.partial! 'page_layouts/page_layout', page_layout: page_layout
    json.url  "
              #{link_to 'Show', page_layout }
              #{link_to 'Edit', edit_page_layout_path(page_layout)}
              #{link_to 'Destroy', page_layout, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end