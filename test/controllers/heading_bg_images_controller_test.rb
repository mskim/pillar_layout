require 'test_helper'

class HeadingBgImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heading_bg_image = heading_bg_images(:one)
  end

  test "should get index" do
    get heading_bg_images_url
    assert_response :success
  end

  test "should get new" do
    get new_heading_bg_image_url
    assert_response :success
  end

  test "should create heading_bg_image" do
    assert_difference('HeadingBgImage.count') do
      post heading_bg_images_url, params: { heading_bg_image: { heading_bg_image: @heading_bg_image.heading_bg_image, page_heading_id: @heading_bg_image.page_heading_id } }
    end

    assert_redirected_to heading_bg_image_url(HeadingBgImage.last)
  end

  test "should show heading_bg_image" do
    get heading_bg_image_url(@heading_bg_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_heading_bg_image_url(@heading_bg_image)
    assert_response :success
  end

  test "should update heading_bg_image" do
    patch heading_bg_image_url(@heading_bg_image), params: { heading_bg_image: { heading_bg_image: @heading_bg_image.heading_bg_image, page_heading_id: @heading_bg_image.page_heading_id } }
    assert_redirected_to heading_bg_image_url(@heading_bg_image)
  end

  test "should destroy heading_bg_image" do
    assert_difference('HeadingBgImage.count', -1) do
      delete heading_bg_image_url(@heading_bg_image)
    end

    assert_redirected_to heading_bg_images_url
  end
end
