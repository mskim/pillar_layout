json.set! :data do
  json.array! @ad_bookings do |ad_booking|
    json.partial! 'ad_bookings/ad_booking', ad_booking: ad_booking
    json.url  "
              #{link_to 'Show', ad_booking }
              #{link_to 'Edit', edit_ad_booking_path(ad_booking)}
              #{link_to 'Destroy', ad_booking, method: :delete, data: { confirm: '정말 삭제하시겠습니까??' }}
              "
  end
end