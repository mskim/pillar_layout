require 'test_helper'

class WorkingArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_article = working_articles(:one)
  end

  test "should get index" do
    get working_articles_url
    assert_response :success
  end

  test "should get new" do
    get new_working_article_url
    assert_response :success
  end

  test "should create working_article" do
    assert_difference('WorkingArticle.count') do
      post working_articles_url, params: { working_article: { body: @working_article.body, column: @working_article.column, email: @working_article.email, image: @working_article.image, is_front_page: @working_article.is_front_page, subject_head: @working_article.subject_head, order: @working_article.order, page_id: @working_article.page_id, personal_image: @working_article.personal_image, profile: @working_article.profile, quote: @working_article.quote, reporter: @working_article.reporter, row: @working_article.row, subtitle: @working_article.subtitle, title: @working_article.title, top_position: @working_article.top_position, top_story: @working_article.top_story } }
    end

    assert_redirected_to working_article_url(WorkingArticle.last)
  end

  test "should show working_article" do
    get working_article_url(@working_article)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_article_url(@working_article)
    assert_response :success
  end

  test "should update working_article" do
    patch working_article_url(@working_article), params: { working_article: { body: @working_article.body, column: @working_article.column, email: @working_article.email, image: @working_article.image, is_front_page: @working_article.is_front_page, subject_head: @working_article.subject_head, order: @working_article.order, page_id: @working_article.page_id, personal_image: @working_article.personal_image, profile: @working_article.profile, quote: @working_article.quote, reporter: @working_article.reporter, row: @working_article.row, subtitle: @working_article.subtitle, title: @working_article.title, top_position: @working_article.top_position, top_story: @working_article.top_story } }
    assert_redirected_to working_article_url(@working_article)
  end

  test "should destroy working_article" do
    assert_difference('WorkingArticle.count', -1) do
      delete working_article_url(@working_article)
    end

    assert_redirected_to working_articles_url
  end
end
