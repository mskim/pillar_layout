require 'test_helper'

class PublicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publication = publications(:one)
  end

  test "should get index" do
    get publications_url
    assert_response :success
  end

  test "should get new" do
    get new_publication_url
    assert_response :success
  end

  test "should create publication" do
    assert_difference('Publication.count') do
      post publications_url, params: { publication: { bottom_margin: @publication.bottom_margin, divider: @publication.divider, page_columns: @publication.page_columns, gutter: @publication.gutter, height: @publication.height, left_margin: @publication.left_margin, lines_per_grid: @publication.lines_per_grid, name: @publication.name, page_count: @publication.page_count, paper_size: @publication.paper_size, right_margin: @publication.right_margin, section_names: @publication.section_names, top_margin: @publication.top_margin, width: @publication.width } }
    end

    assert_redirected_to publication_url(Publication.last)
  end

  test "should show publication" do
    get publication_url(@publication)
    assert_response :success
  end

  test "should get edit" do
    get edit_publication_url(@publication)
    assert_response :success
  end

  test "should update publication" do
    patch publication_url(@publication), params: { publication: { bottom_margin: @publication.bottom_margin, divider: @publication.divider, page_columns: @publication.page_columns, gutter: @publication.gutter, height: @publication.height, left_margin: @publication.left_margin, lines_per_grid: @publication.lines_per_grid, name: @publication.name, page_count: @publication.page_count, paper_size: @publication.paper_size, right_margin: @publication.right_margin, section_names: @publication.section_names, top_margin: @publication.top_margin, width: @publication.width } }
    assert_redirected_to publication_url(@publication)
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete publication_url(@publication)
    end

    assert_redirected_to publications_url
  end
end
