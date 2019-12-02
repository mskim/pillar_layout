require 'rails_helper'

RSpec.describe "ad_bookings/new", type: :view do
  before(:each) do
    assign(:ad_booking, AdBooking.new(
      :publication => nil,
      :ad_list => "MyText"
    ))
  end

  it "renders new ad_booking form" do
    render

    assert_select "form[action=?][method=?]", ad_bookings_path, "post" do

      assert_select "input[name=?]", "ad_booking[publication_id]"

      assert_select "textarea[name=?]", "ad_booking[ad_list]"
    end
  end
end
