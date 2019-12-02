require 'test_helper'

class SectionHeadingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_heading = section_headings(:one)
  end

  test "should get index" do
    get section_headings_url
    assert_response :success
  end

  test "should get new" do
    get new_section_heading_url
    assert_response :success
  end

  test "should create section_heading" do
    assert_difference('SectionHeading.count') do
      post section_headings_url, params: { section_heading: { date: @section_heading.date, layout: @section_heading.layout, page_number: @section_heading.page_number, publication_id: @section_heading.publication_id, section_name: @section_heading.section_name } }
    end

    assert_redirected_to section_heading_url(SectionHeading.last)
  end

  test "should show section_heading" do
    get section_heading_url(@section_heading)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_heading_url(@section_heading)
    assert_response :success
  end

  test "should update section_heading" do
    patch section_heading_url(@section_heading), params: { section_heading: { date: @section_heading.date, layout: @section_heading.layout, page_number: @section_heading.page_number, publication_id: @section_heading.publication_id, section_name: @section_heading.section_name } }
    assert_redirected_to section_heading_url(@section_heading)
  end

  test "should destroy section_heading" do
    assert_difference('SectionHeading.count', -1) do
      delete section_heading_url(@section_heading)
    end

    assert_redirected_to section_headings_url
  end
end
