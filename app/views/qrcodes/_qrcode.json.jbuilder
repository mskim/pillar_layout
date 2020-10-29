json.extract! qrcode, :id, :x, :y, :width, :height, :qr_text, :qrcode_file, :qrcode_type, :web_page_id, :created_at, :updated_at
json.url qrcode_url(qrcode, format: :json)
