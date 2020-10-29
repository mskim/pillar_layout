json.set! :data do
  json.array! @web_pages do |web_page|
    json.partial! 'web_pages/web_page', web_page: web_page
    json.url  "
              #{link_to 'Show', web_page }
              #{link_to 'Edit', edit_web_page_path(web_page)}
              #{link_to 'Destroy', web_page, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end