require 'test_helper'

class ReporterGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reporter_group = reporter_groups(:one)
  end

  test "should get index" do
    get reporter_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_reporter_group_url
    assert_response :success
  end

  test "should create reporter_group" do
    assert_difference('ReporterGroup.count') do
      post reporter_groups_url, params: { reporter_group: { leader: @reporter_group.leader, page_range: @reporter_group.page_range, section: @reporter_group.section } }
    end

    assert_redirected_to reporter_group_url(ReporterGroup.last)
  end

  test "should show reporter_group" do
    get reporter_group_url(@reporter_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_reporter_group_url(@reporter_group)
    assert_response :success
  end

  test "should update reporter_group" do
    patch reporter_group_url(@reporter_group), params: { reporter_group: { leader: @reporter_group.leader, page_range: @reporter_group.page_range, section: @reporter_group.section } }
    assert_redirected_to reporter_group_url(@reporter_group)
  end

  test "should destroy reporter_group" do
    assert_difference('ReporterGroup.count', -1) do
      delete reporter_group_url(@reporter_group)
    end

    assert_redirected_to reporter_groups_url
  end
end
