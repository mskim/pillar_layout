require 'rails_helper'

RSpec.describe "ad_bookings/show", type: :view do
  before(:each) do
    @ad_booking = assign(:ad_booking, AdBooking.create!(
      :publication => nil,
      :ad_list => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
