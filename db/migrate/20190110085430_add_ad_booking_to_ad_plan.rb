class AddAdBookingToAdPlan < ActiveRecord::Migration[5.2]
  def change
    add_reference :ad_plans, :ad_booking, foreign_key: true
  end
end
