require 'test_helper'

class ArticlePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_plan = article_plans(:one)
  end

  test "should get index" do
    get article_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_article_plan_url
    assert_response :success
  end

  test "should create article_plan" do
    assert_difference('ArticlePlan.count') do
      post article_plans_url, params: { article_plan: { order: @article_plan.order, page_plan_id: @article_plan.page_plan_id, reporter: @article_plan.reporter } }
    end

    assert_redirected_to article_plan_url(ArticlePlan.last)
  end

  test "should show article_plan" do
    get article_plan_url(@article_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_plan_url(@article_plan)
    assert_response :success
  end

  test "should update article_plan" do
    patch article_plan_url(@article_plan), params: { article_plan: { order: @article_plan.order, page_plan_id: @article_plan.page_plan_id, reporter: @article_plan.reporter } }
    assert_redirected_to article_plan_url(@article_plan)
  end

  test "should destroy article_plan" do
    assert_difference('ArticlePlan.count', -1) do
      delete article_plan_url(@article_plan)
    end

    assert_redirected_to article_plans_url
  end
end
