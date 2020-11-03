require 'test_helper'

class AnnotationChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation_check = annotation_checks(:one)
  end

  test "should get index" do
    get annotation_checks_url
    assert_response :success
  end

  test "should get new" do
    get new_annotation_check_url
    assert_response :success
  end

  test "should create annotation_check" do
    assert_difference('AnnotationCheck.count') do
      post annotation_checks_url, params: { annotation_check: { annotation_id: @annotation_check.annotation_id, color: @annotation_check.color, height: @annotation_check.height, user_id: @annotation_check.user_id, width: @annotation_check.width, x: @annotation_check.x, y: @annotation_check.y } }
    end

    assert_redirected_to annotation_check_url(AnnotationCheck.last)
  end

  test "should show annotation_check" do
    get annotation_check_url(@annotation_check)
    assert_response :success
  end

  test "should get edit" do
    get edit_annotation_check_url(@annotation_check)
    assert_response :success
  end

  test "should update annotation_check" do
    patch annotation_check_url(@annotation_check), params: { annotation_check: { annotation_id: @annotation_check.annotation_id, color: @annotation_check.color, height: @annotation_check.height, user_id: @annotation_check.user_id, width: @annotation_check.width, x: @annotation_check.x, y: @annotation_check.y } }
    assert_redirected_to annotation_check_url(@annotation_check)
  end

  test "should destroy annotation_check" do
    assert_difference('AnnotationCheck.count', -1) do
      delete annotation_check_url(@annotation_check)
    end

    assert_redirected_to annotation_checks_url
  end
end
