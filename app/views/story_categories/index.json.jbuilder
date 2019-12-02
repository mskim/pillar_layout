json.set! :data do
  json.array! @story_categories do |story_category|
    json.partial! 'story_categories/story_category', story_category: story_category
    json.url  "
              #{link_to '보기', story_category }
              #{link_to '수정', edit_story_category_path(story_category)}
              #{link_to '삭제', story_category, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end