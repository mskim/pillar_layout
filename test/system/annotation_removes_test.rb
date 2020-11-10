require "application_system_test_case"

class AnnotationRemovesTest < ApplicationSystemTestCase
  setup do
    @annotation_remove = annotation_removes(:one)
  end

  test "visiting the index" do
    visit annotation_removes_url
    assert_selector "h1", text: "Annotation Removes"
  end

  test "creating a Annotation remove" do
    visit annotation_removes_url
    click_on "New Annotation Remove"

    fill_in "Annotation", with: @annotation_remove.annotation_id
    fill_in "Color", with: @annotation_remove.color
    fill_in "Height", with: @annotation_remove.height
    fill_in "User", with: @annotation_remove.user_id
    fill_in "Width", with: @annotation_remove.width
    fill_in "X", with: @annotation_remove.x
    fill_in "Y", with: @annotation_remove.y
    click_on "Create Annotation remove"

    assert_text "Annotation remove was successfully created"
    click_on "Back"
  end

  test "updating a Annotation remove" do
    visit annotation_removes_url
    click_on "Edit", match: :first

    fill_in "Annotation", with: @annotation_remove.annotation_id
    fill_in "Color", with: @annotation_remove.color
    fill_in "Height", with: @annotation_remove.height
    fill_in "User", with: @annotation_remove.user_id
    fill_in "Width", with: @annotation_remove.width
    fill_in "X", with: @annotation_remove.x
    fill_in "Y", with: @annotation_remove.y
    click_on "Update Annotation remove"

    assert_text "Annotation remove was successfully updated"
    click_on "Back"
  end

  test "destroying a Annotation remove" do
    visit annotation_removes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Annotation remove was successfully destroyed"
  end
end
