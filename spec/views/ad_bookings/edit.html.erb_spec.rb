require 'rails_helper'

RSpec.describe "ad_bookings/edit", type: :view do
  before(:each) do
    @ad_booking = assign(:ad_booking, AdBooking.create!(
      :publication => nil,
      :ad_list => "MyText"
    ))
  end

  it "renders the edit ad_booking form" do
    render

    assert_select "form[action=?][method=?]", ad_booking_path(@ad_booking), "post" do

      assert_select "input[name=?]", "ad_booking[publication_id]"

      assert_select "textarea[name=?]", "ad_booking[ad_list]"
    end
  end
end
