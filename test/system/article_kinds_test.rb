require "application_system_test_case"

class ArticleKindsTest < ApplicationSystemTestCase
  setup do
    @article_kind = article_kinds(:one)
  end

  test "visiting the index" do
    visit article_kinds_url
    assert_selector "h1", text: "Article Kinds"
  end

  test "creating a Article kind" do
    visit article_kinds_url
    click_on "New Article Kind"

    fill_in "Bottoms space in lines", with: @article_kind.bottoms_space_in_lines
    fill_in "Input fields", with: @article_kind.input_fields
    fill_in "Layout erb", with: @article_kind.layout_erb
    fill_in "Line draw sides", with: @article_kind.line_draw_sides
    fill_in "Name", with: @article_kind.name
    fill_in "Publication", with: @article_kind.publication_id
    click_on "Create Article kind"

    assert_text "Article kind was successfully created"
    click_on "Back"
  end

  test "updating a Article kind" do
    visit article_kinds_url
    click_on "Edit", match: :first

    fill_in "Bottoms space in lines", with: @article_kind.bottoms_space_in_lines
    fill_in "Input fields", with: @article_kind.input_fields
    fill_in "Layout erb", with: @article_kind.layout_erb
    fill_in "Line draw sides", with: @article_kind.line_draw_sides
    fill_in "Name", with: @article_kind.name
    fill_in "Publication", with: @article_kind.publication_id
    click_on "Update Article kind"

    assert_text "Article kind was successfully updated"
    click_on "Back"
  end

  test "destroying a Article kind" do
    visit article_kinds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Article kind was successfully destroyed"
  end
end
