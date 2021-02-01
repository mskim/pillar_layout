require "test_helper"

class ArticleKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_kind = article_kinds(:one)
  end

  test "should get index" do
    get article_kinds_url
    assert_response :success
  end

  test "should get new" do
    get new_article_kind_url
    assert_response :success
  end

  test "should create article_kind" do
    assert_difference('ArticleKind.count') do
      post article_kinds_url, params: { article_kind: { bottoms_space_in_lines: @article_kind.bottoms_space_in_lines, input_fields: @article_kind.input_fields, layout_erb: @article_kind.layout_erb, line_draw_sides: @article_kind.line_draw_sides, name: @article_kind.name, publication_id: @article_kind.publication_id } }
    end

    assert_redirected_to article_kind_url(ArticleKind.last)
  end

  test "should show article_kind" do
    get article_kind_url(@article_kind)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_kind_url(@article_kind)
    assert_response :success
  end

  test "should update article_kind" do
    patch article_kind_url(@article_kind), params: { article_kind: { bottoms_space_in_lines: @article_kind.bottoms_space_in_lines, input_fields: @article_kind.input_fields, layout_erb: @article_kind.layout_erb, line_draw_sides: @article_kind.line_draw_sides, name: @article_kind.name, publication_id: @article_kind.publication_id } }
    assert_redirected_to article_kind_url(@article_kind)
  end

  test "should destroy article_kind" do
    assert_difference('ArticleKind.count', -1) do
      delete article_kind_url(@article_kind)
    end

    assert_redirected_to article_kinds_url
  end
end
