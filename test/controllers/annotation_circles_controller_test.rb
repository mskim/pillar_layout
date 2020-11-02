require 'test_helper'

class AnnotationCirclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation_circle = annotation_circles(:one)
  end

  test "should get index" do
    get annotation_circles_url
    assert_response :success
  end

  test "should get new" do
    get new_annotation_circle_url
    assert_response :success
  end

  test "should create annotation_circle" do
    assert_difference('AnnotationCircle.count') do
      post annotation_circles_url, params: { annotation_circle: { annotation_id: @annotation_circle.annotation_id, color: @annotation_circle.color, height: @annotation_circle.height, user_id: @annotation_circle.user_id, width: @annotation_circle.width, x: @annotation_circle.x, y: @annotation_circle.y } }
    end

    assert_redirected_to annotation_circle_url(AnnotationCircle.last)
  end

  test "should show annotation_circle" do
    get annotation_circle_url(@annotation_circle)
    assert_response :success
  end

  test "should get edit" do
    get edit_annotation_circle_url(@annotation_circle)
    assert_response :success
  end

  test "should update annotation_circle" do
    patch annotation_circle_url(@annotation_circle), params: { annotation_circle: { annotation_id: @annotation_circle.annotation_id, color: @annotation_circle.color, height: @annotation_circle.height, user_id: @annotation_circle.user_id, width: @annotation_circle.width, x: @annotation_circle.x, y: @annotation_circle.y } }
    assert_redirected_to annotation_circle_url(@annotation_circle)
  end

  test "should destroy annotation_circle" do
    assert_difference('AnnotationCircle.count', -1) do
      delete annotation_circle_url(@annotation_circle)
    end

    assert_redirected_to annotation_circles_url
  end
end
