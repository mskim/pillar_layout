require "application_system_test_case"

class PageHeadingKindsTest < ApplicationSystemTestCase
  setup do
    @page_heading_kind = page_heading_kinds(:one)
  end

  test "visiting the index" do
    visit page_heading_kinds_url
    assert_selector "h1", text: "Page Heading Kinds"
  end

  test "creating a Page heading kind" do
    visit page_heading_kinds_url
    click_on "New Page Heading Kind"

    fill_in "Bg image", with: @page_heading_kind.bg_image
    fill_in "Height in lines", with: @page_heading_kind.height_in_lines
    fill_in "Layout erb", with: @page_heading_kind.layout_erb
    fill_in "Page type", with: @page_heading_kind.page_type
    fill_in "Publication", with: @page_heading_kind.publication
    click_on "Create Page heading kind"

    assert_text "Page heading kind was successfully created"
    click_on "Back"
  end

  test "updating a Page heading kind" do
    visit page_heading_kinds_url
    click_on "Edit", match: :first

    fill_in "Bg image", with: @page_heading_kind.bg_image
    fill_in "Height in lines", with: @page_heading_kind.height_in_lines
    fill_in "Layout erb", with: @page_heading_kind.layout_erb
    fill_in "Page type", with: @page_heading_kind.page_type
    fill_in "Publication", with: @page_heading_kind.publication
    click_on "Update Page heading kind"

    assert_text "Page heading kind was successfully updated"
    click_on "Back"
  end

  test "destroying a Page heading kind" do
    visit page_heading_kinds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page heading kind was successfully destroyed"
  end
end
