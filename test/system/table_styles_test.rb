require "application_system_test_case"

class TableStylesTest < ApplicationSystemTestCase
  setup do
    @table_style = table_styles(:one)
  end

  test "visiting the index" do
    visit table_styles_url
    assert_selector "h1", text: "Table Styles"
  end

  test "creating a Table style" do
    visit table_styles_url
    click_on "New Table Style"

    fill_in "Category level", with: @table_style.category_level
    fill_in "Column", with: @table_style.column
    fill_in "Heading level", with: @table_style.heading_level
    fill_in "Layout", with: @table_style.layout
    fill_in "Name", with: @table_style.name
    fill_in "Row", with: @table_style.row
    click_on "Create Table style"

    assert_text "Table style was successfully created"
    click_on "Back"
  end

  test "updating a Table style" do
    visit table_styles_url
    click_on "Edit", match: :first

    fill_in "Category level", with: @table_style.category_level
    fill_in "Column", with: @table_style.column
    fill_in "Heading level", with: @table_style.heading_level
    fill_in "Layout", with: @table_style.layout
    fill_in "Name", with: @table_style.name
    fill_in "Row", with: @table_style.row
    click_on "Update Table style"

    assert_text "Table style was successfully updated"
    click_on "Back"
  end

  test "destroying a Table style" do
    visit table_styles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Table style was successfully destroyed"
  end
end
