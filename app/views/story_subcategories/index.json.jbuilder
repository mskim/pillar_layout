json.set! :data do
  json.array! @story_subcategories do |story_subcategory|
    json.partial! 'story_subcategories/story_subcategory', story_subcategory: story_subcategory
    json.url  "
              #{link_to '보기', story_subcategory }
              #{link_to '수정', edit_story_subcategory_path(story_subcategory)}
              #{link_to '삭제', story_subcategory, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end