json.set! :data do
  json.array! @ad_plans do |ad_plan|
    json.partial! 'ad_plans/ad_plan', ad_plan: ad_plan
    json.url  "
              #{link_to 'Show', ad_plan }
              #{link_to 'Edit', edit_ad_plan_path(ad_plan)}
              #{link_to 'Destroy', ad_plan, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end