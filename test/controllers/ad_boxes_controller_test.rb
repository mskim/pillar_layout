require 'test_helper'

class AdBoxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad_box = ad_boxes(:one)
  end

  test "should get index" do
    get ad_boxes_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_box_url
    assert_response :success
  end

  test "should create ad_box" do
    assert_difference('AdBox.count') do
      post ad_boxes_url, params: { ad_box: { ad_type: @ad_box.ad_type, advertiser: @ad_box.advertiser, column: @ad_box.column, page_id: @ad_box.page_id, row: @ad_box.row } }
    end

    assert_redirected_to ad_box_url(AdBox.last)
  end

  test "should show ad_box" do
    get ad_box_url(@ad_box)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_box_url(@ad_box)
    assert_response :success
  end

  test "should update ad_box" do
    patch ad_box_url(@ad_box), params: { ad_box: { ad_type: @ad_box.ad_type, advertiser: @ad_box.advertiser, column: @ad_box.column, page_id: @ad_box.page_id, row: @ad_box.row } }
    assert_redirected_to ad_box_url(@ad_box)
  end

  test "should destroy ad_box" do
    assert_difference('AdBox.count', -1) do
      delete ad_box_url(@ad_box)
    end

    assert_redirected_to ad_boxes_url
  end
end
