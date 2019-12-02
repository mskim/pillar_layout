require 'rails_helper'

RSpec.describe "ad_bookings/index", type: :view do
  before(:each) do
    assign(:ad_bookings, [
      AdBooking.create!(
        :publication => nil,
        :ad_list => "MyText"
      ),
      AdBooking.create!(
        :publication => nil,
        :ad_list => "MyText"
      )
    ])
  end

  it "renders a list of ad_bookings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
