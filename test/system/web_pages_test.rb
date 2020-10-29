require "application_system_test_case"

class WebPagesTest < ApplicationSystemTestCase
  setup do
    @web_page = web_pages(:one)
  end

  test "visiting the index" do
    visit web_pages_url
    assert_selector "h1", text: "Web Pages"
  end

  test "creating a Web page" do
    visit web_pages_url
    click_on "New Web Page"

    fill_in "Current tool", with: @web_page.current_tool
    fill_in "Height", with: @web_page.height
    fill_in "Issue", with: @web_page.issue_id
    fill_in "Page number", with: @web_page.page_number
    fill_in "Text content", with: @web_page.text_content
    fill_in "Text position", with: @web_page.text_position
    check "Toc" if @web_page.toc
    fill_in "Width", with: @web_page.width
    click_on "Create Web page"

    assert_text "Web page was successfully created"
    click_on "Back"
  end

  test "updating a Web page" do
    visit web_pages_url
    click_on "Edit", match: :first

    fill_in "Current tool", with: @web_page.current_tool
    fill_in "Height", with: @web_page.height
    fill_in "Issue", with: @web_page.issue_id
    fill_in "Page number", with: @web_page.page_number
    fill_in "Text content", with: @web_page.text_content
    fill_in "Text position", with: @web_page.text_position
    check "Toc" if @web_page.toc
    fill_in "Width", with: @web_page.width
    click_on "Update Web page"

    assert_text "Web page was successfully updated"
    click_on "Back"
  end

  test "destroying a Web page" do
    visit web_pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Web page was successfully destroyed"
  end
end
