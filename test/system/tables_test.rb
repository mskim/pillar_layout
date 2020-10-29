require "application_system_test_case"

class TablesTest < ApplicationSystemTestCase
  setup do
    @table = tables(:one)
  end

  test "visiting the index" do
    visit tables_url
    assert_selector "h1", text: "Tables"
  end

  test "creating a Table" do
    visit tables_url
    click_on "New Table"

    fill_in "Body", with: @table.body
    fill_in "Column", with: @table.column
    fill_in "Extended line count", with: @table.extended_line_count
    fill_in "Row", with: @table.row
    fill_in "Source", with: @table.source
    fill_in "Table style", with: @table.table_style_id
    fill_in "Title", with: @table.title
    fill_in "Working article", with: @table.working_article_id
    click_on "Create Table"

    assert_text "Table was successfully created"
    click_on "Back"
  end

  test "updating a Table" do
    visit tables_url
    click_on "Edit", match: :first

    fill_in "Body", with: @table.body
    fill_in "Column", with: @table.column
    fill_in "Extended line count", with: @table.extended_line_count
    fill_in "Row", with: @table.row
    fill_in "Source", with: @table.source
    fill_in "Table style", with: @table.table_style_id
    fill_in "Title", with: @table.title
    fill_in "Working article", with: @table.working_article_id
    click_on "Update Table"

    assert_text "Table was successfully updated"
    click_on "Back"
  end

  test "destroying a Table" do
    visit tables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Table was successfully destroyed"
  end
end
