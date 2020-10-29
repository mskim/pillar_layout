json.set! :data do
  json.array! @qrcodes do |qrcode|
    json.partial! 'qrcodes/qrcode', qrcode: qrcode
    json.url  "
              #{link_to 'Show', qrcode }
              #{link_to 'Edit', edit_qrcode_path(qrcode)}
              #{link_to 'Destroy', qrcode, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end