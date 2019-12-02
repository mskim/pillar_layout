require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should get new" do
    get new_page_url
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post pages_url, params: { page: { ad_type: @page.ad_type, color_page: @page.color_page, column: @page.column, issue_id: @page.issue_id, page_number: @page.page_number, profile: @page.profile, row: @page.row, section_name: @page.section_name, story_count: @page.story_count, template_id: @page.template_id } }
    end

    assert_redirected_to page_url(Page.last)
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_url(@page)
    assert_response :success
  end

  test "should update page" do
    patch page_url(@page), params: { page: { ad_type: @page.ad_type, color_page: @page.color_page, column: @page.column, issue_id: @page.issue_id, page_number: @page.page_number, profile: @page.profile, row: @page.row, section_name: @page.section_name, story_count: @page.story_count, template_id: @page.template_id } }
    assert_redirected_to page_url(@page)
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
