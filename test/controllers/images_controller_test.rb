require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
  end

  test "should get index" do
    get images_url
    assert_response :success
  end

  test "should get new" do
    get new_image_url
    assert_response :success
  end

  test "should create image" do
    assert_difference('Image.count') do
      post images_url, params: { image: { working_article_id: @image.working_article_id, caption: @image.caption, caption_title: @image.caption_title, column: @image.column, extra_height_in_lines: @image.extra_height_in_lines, image_path: @image.image_path, position: @image.position, row: @image.row } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test "should show image" do
    get image_url(@image)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_url(@image)
    assert_response :success
  end

  test "should update image" do
    patch image_url(@image), params: { image: { working_article_id: @image.working_article_id, caption: @image.caption, caption_title: @image.caption_title, column: @image.column, extra_height_in_lines: @image.extra_height_in_lines, image_path: @image.image_path, position: @image.position, row: @image.row } }
    assert_redirected_to image_url(@image)
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete image_url(@image)
    end

    assert_redirected_to images_url
  end
end
