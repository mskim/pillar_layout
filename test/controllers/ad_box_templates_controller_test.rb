require 'test_helper'

class AdBoxTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad_box_template = ad_box_templates(:one)
  end

  test "should get index" do
    get ad_box_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_box_template_url
    assert_response :success
  end

  test "should create ad_box_template" do
    assert_difference('AdBoxTemplate.count') do
      post ad_box_templates_url, params: { ad_box_template: { ad_type: @ad_box_template.ad_type, column: @ad_box_template.column, row: @ad_box_template.row, section_id: @ad_box_template.section_id } }
    end

    assert_redirected_to ad_box_template_url(AdBoxTemplate.last)
  end

  test "should show ad_box_template" do
    get ad_box_template_url(@ad_box_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_box_template_url(@ad_box_template)
    assert_response :success
  end

  test "should update ad_box_template" do
    patch ad_box_template_url(@ad_box_template), params: { ad_box_template: { ad_type: @ad_box_template.ad_type, column: @ad_box_template.column, row: @ad_box_template.row, section_id: @ad_box_template.section_id } }
    assert_redirected_to ad_box_template_url(@ad_box_template)
  end

  test "should destroy ad_box_template" do
    assert_difference('AdBoxTemplate.count', -1) do
      delete ad_box_template_url(@ad_box_template)
    end

    assert_redirected_to ad_box_templates_url
  end
end
