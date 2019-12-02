require 'test_helper'

class StrokeStylesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stroke_style = stroke_styles(:one)
  end

  test "should get index" do
    get stroke_styles_url
    assert_response :success
  end

  test "should get new" do
    get new_stroke_style_url
    assert_response :success
  end

  test "should create stroke_style" do
    assert_difference('StrokeStyle.count') do
      post stroke_styles_url, params: { stroke_style: { klass: @stroke_style.klass, name: @stroke_style.name, publication_id: @stroke_style.publication_id, stroke: @stroke_style.stroke } }
    end

    assert_redirected_to stroke_style_url(StrokeStyle.last)
  end

  test "should show stroke_style" do
    get stroke_style_url(@stroke_style)
    assert_response :success
  end

  test "should get edit" do
    get edit_stroke_style_url(@stroke_style)
    assert_response :success
  end

  test "should update stroke_style" do
    patch stroke_style_url(@stroke_style), params: { stroke_style: { klass: @stroke_style.klass, name: @stroke_style.name, publication_id: @stroke_style.publication_id, stroke: @stroke_style.stroke } }
    assert_redirected_to stroke_style_url(@stroke_style)
  end

  test "should destroy stroke_style" do
    assert_difference('StrokeStyle.count', -1) do
      delete stroke_style_url(@stroke_style)
    end

    assert_redirected_to stroke_styles_url
  end
end
