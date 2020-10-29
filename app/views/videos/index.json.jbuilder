json.set! :data do
  json.array! @videos do |video|
    json.partial! 'videos/video', video: video
    json.url  "
              #{link_to 'Show', video }
              #{link_to 'Edit', edit_video_path(video)}
              #{link_to 'Destroy', video, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end