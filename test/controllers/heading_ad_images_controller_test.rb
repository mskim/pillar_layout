require 'test_helper'

class HeadingAdImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heading_ad_image = heading_ad_images(:one)
  end

  test "should get index" do
    get heading_ad_images_url
    assert_response :success
  end

  test "should get new" do
    get new_heading_ad_image_url
    assert_response :success
  end

  test "should create heading_ad_image" do
    assert_difference('HeadingAdImage.count') do
      post heading_ad_images_url, params: { heading_ad_image: { ad_image: @heading_ad_image.ad_image, advertiser: @heading_ad_image.advertiser, height: @heading_ad_image.height, height_in_unit: @heading_ad_image.height_in_unit, page_heading_id: @heading_ad_image.page_heading_id, width: @heading_ad_image.width, width_in_unit: @heading_ad_image.width_in_unit, x: @heading_ad_image.x, x_in_unit: @heading_ad_image.x_in_unit, y: @heading_ad_image.y, y_in_unit: @heading_ad_image.y_in_unit } }
    end

    assert_redirected_to heading_ad_image_url(HeadingAdImage.last)
  end

  test "should show heading_ad_image" do
    get heading_ad_image_url(@heading_ad_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_heading_ad_image_url(@heading_ad_image)
    assert_response :success
  end

  test "should update heading_ad_image" do
    patch heading_ad_image_url(@heading_ad_image), params: { heading_ad_image: { ad_image: @heading_ad_image.ad_image, advertiser: @heading_ad_image.advertiser, height: @heading_ad_image.height, height_in_unit: @heading_ad_image.height_in_unit, page_heading_id: @heading_ad_image.page_heading_id, width: @heading_ad_image.width, width_in_unit: @heading_ad_image.width_in_unit, x: @heading_ad_image.x, x_in_unit: @heading_ad_image.x_in_unit, y: @heading_ad_image.y, y_in_unit: @heading_ad_image.y_in_unit } }
    assert_redirected_to heading_ad_image_url(@heading_ad_image)
  end

  test "should destroy heading_ad_image" do
    assert_difference('HeadingAdImage.count', -1) do
      delete heading_ad_image_url(@heading_ad_image)
    end

    assert_redirected_to heading_ad_images_url
  end
end
