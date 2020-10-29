class CreateQrcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :qrcodes do |t|
      t.decimal :x
      t.decimal :y
      t.decimal :width
      t.decimal :height
      t.string :qr_text
      t.string :qrcode_file
      t.string :qrcode_type
      t.references :web_page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
