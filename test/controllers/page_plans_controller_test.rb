require 'test_helper'

class PagePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_plan = page_plans(:one)
  end

  test "should get index" do
    get page_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_page_plan_url
    assert_response :success
  end

  test "should create page_plan" do
    assert_difference('PagePlan.count') do
      post page_plans_url, params: { page_plan: { ad_type: @page_plan.ad_type, advertiser: @page_plan.advertiser, color_page: @page_plan.color_page, issue_id: @page_plan.issue_id, page_number: @page_plan.page_number, section_name: @page_plan.section_name } }
    end

    assert_redirected_to page_plan_url(PagePlan.last)
  end

  test "should show page_plan" do
    get page_plan_url(@page_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_plan_url(@page_plan)
    assert_response :success
  end

  test "should update page_plan" do
    patch page_plan_url(@page_plan), params: { page_plan: { ad_type: @page_plan.ad_type, advertiser: @page_plan.advertiser, color_page: @page_plan.color_page, issue_id: @page_plan.issue_id, page_number: @page_plan.page_number, section_name: @page_plan.section_name } }
    assert_redirected_to page_plan_url(@page_plan)
  end

  test "should destroy page_plan" do
    assert_difference('PagePlan.count', -1) do
      delete page_plan_url(@page_plan)
    end

    assert_redirected_to page_plans_url
  end
end
