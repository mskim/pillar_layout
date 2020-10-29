require "application_system_test_case"

class QrcodesTest < ApplicationSystemTestCase
  setup do
    @qrcode = qrcodes(:one)
  end

  test "visiting the index" do
    visit qrcodes_url
    assert_selector "h1", text: "Qrcodes"
  end

  test "creating a Qrcode" do
    visit qrcodes_url
    click_on "New Qrcode"

    fill_in "Height", with: @qrcode.height
    fill_in "Qr text", with: @qrcode.qr_text
    fill_in "Qrcode file", with: @qrcode.qrcode_file
    fill_in "Qrcode type", with: @qrcode.qrcode_type
    fill_in "Web page", with: @qrcode.web_page_id
    fill_in "Width", with: @qrcode.width
    fill_in "X", with: @qrcode.x
    fill_in "Y", with: @qrcode.y
    click_on "Create Qrcode"

    assert_text "Qrcode was successfully created"
    click_on "Back"
  end

  test "updating a Qrcode" do
    visit qrcodes_url
    click_on "Edit", match: :first

    fill_in "Height", with: @qrcode.height
    fill_in "Qr text", with: @qrcode.qr_text
    fill_in "Qrcode file", with: @qrcode.qrcode_file
    fill_in "Qrcode type", with: @qrcode.qrcode_type
    fill_in "Web page", with: @qrcode.web_page_id
    fill_in "Width", with: @qrcode.width
    fill_in "X", with: @qrcode.x
    fill_in "Y", with: @qrcode.y
    click_on "Update Qrcode"

    assert_text "Qrcode was successfully updated"
    click_on "Back"
  end

  test "destroying a Qrcode" do
    visit qrcodes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Qrcode was successfully destroyed"
  end
end
