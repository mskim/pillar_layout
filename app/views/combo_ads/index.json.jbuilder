json.set! :data do
  json.array! @combo_ads do |combo_ad|
    json.partial! 'combo_ads/combo_ad', combo_ad: combo_ad
    json.url  "
              #{link_to 'Show', combo_ad }
              #{link_to 'Edit', edit_combo_ad_path(combo_ad)}
              #{link_to 'Destroy', combo_ad, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end