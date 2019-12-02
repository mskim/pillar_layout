require 'test_helper'

class TextStylesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_style = text_styles(:one)
  end

  test "should get index" do
    get text_styles_url
    assert_response :success
  end

  test "should get new" do
    get new_text_style_url
    assert_response :success
  end

  test "should create text_style" do
    assert_difference('TextStyle.count') do
      post text_styles_url, params: { text_style: { alignment: @text_style.alignment, color: @text_style.color, english: @text_style.english, font: @text_style.font, name: @text_style.name, publication_id: @text_style.publication_id, size: @text_style.font_size, space_after_in_lines: @text_style.space_after_in_lines, space_before_in_lines: @text_style.space_before_in_lines, text_height_in_lines: @text_style.text_height_in_lines, tracking: @text_style.tracking } }
    end

    assert_redirected_to text_style_url(TextStyle.last)
  end

  test "should show text_style" do
    get text_style_url(@text_style)
    assert_response :success
  end

  test "should get edit" do
    get edit_text_style_url(@text_style)
    assert_response :success
  end

  test "should update text_style" do
    patch text_style_url(@text_style), params: { text_style: { alignment: @text_style.alignment, color: @text_style.color, english: @text_style.english, font: @text_style.font, name: @text_style.name, publication_id: @text_style.publication_id, size: @text_style.font_size, space_after_in_lines: @text_style.space_after_in_lines, space_before_in_lines: @text_style.space_before_in_lines, text_height_in_lines: @text_style.text_height_in_lines, tracking: @text_style.tracking } }
    assert_redirected_to text_style_url(@text_style)
  end

  test "should destroy text_style" do
    assert_difference('TextStyle.count', -1) do
      delete text_style_url(@text_style)
    end

    assert_redirected_to text_styles_url
  end
end
