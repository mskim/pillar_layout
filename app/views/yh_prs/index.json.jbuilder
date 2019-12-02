json.set! :data do
  json.array! @yh_prs do |yh_pr|
    json.partial! 'yh_prs/yh_pr', yh_pr: yh_pr
    json.url  "
              #{link_to 'Show', yh_pr }
              #{link_to 'Edit', edit_yh_pr_path(yh_pr)}
              #{link_to 'Destroy', yh_pr, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end