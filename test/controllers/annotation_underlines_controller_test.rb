require 'test_helper'

class AnnotationUnderlinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation_underline = annotation_underlines(:one)
  end

  test "should get index" do
    get annotation_underlines_url
    assert_response :success
  end

  test "should get new" do
    get new_annotation_underline_url
    assert_response :success
  end

  test "should create annotation_underline" do
    assert_difference('AnnotationUnderline.count') do
      post annotation_underlines_url, params: { annotation_underline: { annotation_id: @annotation_underline.annotation_id, color: @annotation_underline.color, height: @annotation_underline.height, user_id: @annotation_underline.user_id, width: @annotation_underline.width, x: @annotation_underline.x, y: @annotation_underline.y } }
    end

    assert_redirected_to annotation_underline_url(AnnotationUnderline.last)
  end

  test "should show annotation_underline" do
    get annotation_underline_url(@annotation_underline)
    assert_response :success
  end

  test "should get edit" do
    get edit_annotation_underline_url(@annotation_underline)
    assert_response :success
  end

  test "should update annotation_underline" do
    patch annotation_underline_url(@annotation_underline), params: { annotation_underline: { annotation_id: @annotation_underline.annotation_id, color: @annotation_underline.color, height: @annotation_underline.height, user_id: @annotation_underline.user_id, width: @annotation_underline.width, x: @annotation_underline.x, y: @annotation_underline.y } }
    assert_redirected_to annotation_underline_url(@annotation_underline)
  end

  test "should destroy annotation_underline" do
    assert_difference('AnnotationUnderline.count', -1) do
      delete annotation_underline_url(@annotation_underline)
    end

    assert_redirected_to annotation_underlines_url
  end
end
