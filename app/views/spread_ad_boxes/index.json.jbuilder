json.set! :data do
  json.array! @spread_ad_boxes do |spread_ad_box|
    json.partial! 'spread_ad_boxes/spread_ad_box', spread_ad_box: spread_ad_box
    json.url  "
              #{link_to 'Show', spread_ad_box }
              #{link_to 'Edit', edit_spread_ad_box_path(spread_ad_box)}
              #{link_to 'Destroy', spread_ad_box, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end