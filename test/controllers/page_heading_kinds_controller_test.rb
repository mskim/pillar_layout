require "test_helper"

class PageHeadingKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_heading_kind = page_heading_kinds(:one)
  end

  test "should get index" do
    get page_heading_kinds_url
    assert_response :success
  end

  test "should get new" do
    get new_page_heading_kind_url
    assert_response :success
  end

  test "should create page_heading_kind" do
    assert_difference('PageHeadingKind.count') do
      post page_heading_kinds_url, params: { page_heading_kind: { bg_image: @page_heading_kind.bg_image, height_in_lines: @page_heading_kind.height_in_lines, layout_erb: @page_heading_kind.layout_erb, page_type: @page_heading_kind.page_type, publication: @page_heading_kind.publication } }
    end

    assert_redirected_to page_heading_kind_url(PageHeadingKind.last)
  end

  test "should show page_heading_kind" do
    get page_heading_kind_url(@page_heading_kind)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_heading_kind_url(@page_heading_kind)
    assert_response :success
  end

  test "should update page_heading_kind" do
    patch page_heading_kind_url(@page_heading_kind), params: { page_heading_kind: { bg_image: @page_heading_kind.bg_image, height_in_lines: @page_heading_kind.height_in_lines, layout_erb: @page_heading_kind.layout_erb, page_type: @page_heading_kind.page_type, publication: @page_heading_kind.publication } }
    assert_redirected_to page_heading_kind_url(@page_heading_kind)
  end

  test "should destroy page_heading_kind" do
    assert_difference('PageHeadingKind.count', -1) do
      delete page_heading_kind_url(@page_heading_kind)
    end

    assert_redirected_to page_heading_kinds_url
  end
end
