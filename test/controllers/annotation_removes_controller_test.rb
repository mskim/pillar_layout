require 'test_helper'

class AnnotationRemovesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation_remove = annotation_removes(:one)
  end

  test "should get index" do
    get annotation_removes_url
    assert_response :success
  end

  test "should get new" do
    get new_annotation_remove_url
    assert_response :success
  end

  test "should create annotation_remove" do
    assert_difference('AnnotationRemove.count') do
      post annotation_removes_url, params: { annotation_remove: { annotation_id: @annotation_remove.annotation_id, color: @annotation_remove.color, height: @annotation_remove.height, user_id: @annotation_remove.user_id, width: @annotation_remove.width, x: @annotation_remove.x, y: @annotation_remove.y } }
    end

    assert_redirected_to annotation_remove_url(AnnotationRemove.last)
  end

  test "should show annotation_remove" do
    get annotation_remove_url(@annotation_remove)
    assert_response :success
  end

  test "should get edit" do
    get edit_annotation_remove_url(@annotation_remove)
    assert_response :success
  end

  test "should update annotation_remove" do
    patch annotation_remove_url(@annotation_remove), params: { annotation_remove: { annotation_id: @annotation_remove.annotation_id, color: @annotation_remove.color, height: @annotation_remove.height, user_id: @annotation_remove.user_id, width: @annotation_remove.width, x: @annotation_remove.x, y: @annotation_remove.y } }
    assert_redirected_to annotation_remove_url(@annotation_remove)
  end

  test "should destroy annotation_remove" do
    assert_difference('AnnotationRemove.count', -1) do
      delete annotation_remove_url(@annotation_remove)
    end

    assert_redirected_to annotation_removes_url
  end
end
