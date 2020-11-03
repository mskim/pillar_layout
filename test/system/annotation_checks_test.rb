require "application_system_test_case"

class AnnotationChecksTest < ApplicationSystemTestCase
  setup do
    @annotation_check = annotation_checks(:one)
  end

  test "visiting the index" do
    visit annotation_checks_url
    assert_selector "h1", text: "Annotation Checks"
  end

  test "creating a Annotation check" do
    visit annotation_checks_url
    click_on "New Annotation Check"

    fill_in "Annotation", with: @annotation_check.annotation_id
    fill_in "Color", with: @annotation_check.color
    fill_in "Height", with: @annotation_check.height
    fill_in "User", with: @annotation_check.user_id
    fill_in "Width", with: @annotation_check.width
    fill_in "X", with: @annotation_check.x
    fill_in "Y", with: @annotation_check.y
    click_on "Create Annotation check"

    assert_text "Annotation check was successfully created"
    click_on "Back"
  end

  test "updating a Annotation check" do
    visit annotation_checks_url
    click_on "Edit", match: :first

    fill_in "Annotation", with: @annotation_check.annotation_id
    fill_in "Color", with: @annotation_check.color
    fill_in "Height", with: @annotation_check.height
    fill_in "User", with: @annotation_check.user_id
    fill_in "Width", with: @annotation_check.width
    fill_in "X", with: @annotation_check.x
    fill_in "Y", with: @annotation_check.y
    click_on "Update Annotation check"

    assert_text "Annotation check was successfully updated"
    click_on "Back"
  end

  test "destroying a Annotation check" do
    visit annotation_checks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Annotation check was successfully destroyed"
  end
end
