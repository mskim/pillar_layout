require 'test_helper'

class PageHeadingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_heading = page_headings(:one)
  end

  test "should get index" do
    get page_headings_url
    assert_response :success
  end

  test "should get new" do
    get new_page_heading_url
    assert_response :success
  end

  test "should create page_heading" do
    assert_difference('PageHeading.count') do
      post page_headings_url, params: { page_heading: { date: @page_heading.date, page_number: @page_heading.page_number, publication_id: @page_heading.publication_id, section_name: @page_heading.section_name } }
    end

    assert_redirected_to page_heading_url(PageHeading.last)
  end

  test "should show page_heading" do
    get page_heading_url(@page_heading)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_heading_url(@page_heading)
    assert_response :success
  end

  test "should update page_heading" do
    patch page_heading_url(@page_heading), params: { page_heading: { date: @page_heading.date, page_number: @page_heading.page_number, publication_id: @page_heading.publication_id, section_name: @page_heading.section_name } }
    assert_redirected_to page_heading_url(@page_heading)
  end

  test "should destroy page_heading" do
    assert_difference('PageHeading.count', -1) do
      delete page_heading_url(@page_heading)
    end

    assert_redirected_to page_headings_url
  end
end
