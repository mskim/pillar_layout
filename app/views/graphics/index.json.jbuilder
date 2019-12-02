json.set! :data do
  json.array! @graphics do |graphic|
    json.partial! 'graphics/graphic', graphic: graphic
    json.url  "
              #{link_to 'Show', graphic }
              #{link_to 'Edit', edit_graphic_path(graphic)}
              #{link_to 'Destroy', graphic, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end