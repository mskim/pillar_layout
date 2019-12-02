json.set! :data do
  json.array! @layout_nodes do |layout_node|
    json.partial! 'layout_nodes/layout_node', layout_node: layout_node
    json.url  "
              #{link_to 'Show', layout_node }
              #{link_to 'Edit', edit_layout_node_path(layout_node)}
              #{link_to 'Destroy', layout_node, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end