require 'test_helper'

class QrcodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qrcode = qrcodes(:one)
  end

  test "should get index" do
    get qrcodes_url
    assert_response :success
  end

  test "should get new" do
    get new_qrcode_url
    assert_response :success
  end

  test "should create qrcode" do
    assert_difference('Qrcode.count') do
      post qrcodes_url, params: { qrcode: { height: @qrcode.height, qr_text: @qrcode.qr_text, qrcode_file: @qrcode.qrcode_file, qrcode_type: @qrcode.qrcode_type, web_page_id: @qrcode.web_page_id, width: @qrcode.width, x: @qrcode.x, y: @qrcode.y } }
    end

    assert_redirected_to qrcode_url(Qrcode.last)
  end

  test "should show qrcode" do
    get qrcode_url(@qrcode)
    assert_response :success
  end

  test "should get edit" do
    get edit_qrcode_url(@qrcode)
    assert_response :success
  end

  test "should update qrcode" do
    patch qrcode_url(@qrcode), params: { qrcode: { height: @qrcode.height, qr_text: @qrcode.qr_text, qrcode_file: @qrcode.qrcode_file, qrcode_type: @qrcode.qrcode_type, web_page_id: @qrcode.web_page_id, width: @qrcode.width, x: @qrcode.x, y: @qrcode.y } }
    assert_redirected_to qrcode_url(@qrcode)
  end

  test "should destroy qrcode" do
    assert_difference('Qrcode.count', -1) do
      delete qrcode_url(@qrcode)
    end

    assert_redirected_to qrcodes_url
  end
end
