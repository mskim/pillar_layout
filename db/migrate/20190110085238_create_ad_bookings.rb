class CreateAdBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_bookings do |t|
      t.references :publication, foreign_key: true
      t.date :date
      t.text :ad_list

      t.timestamps
    end
  end
end
