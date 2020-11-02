require "application_system_test_case"

class AnnotationUnderlinesTest < ApplicationSystemTestCase
  setup do
    @annotation_underline = annotation_underlines(:one)
  end

  test "visiting the index" do
    visit annotation_underlines_url
    assert_selector "h1", text: "Annotation Underlines"
  end

  test "creating a Annotation underline" do
    visit annotation_underlines_url
    click_on "New Annotation Underline"

    fill_in "Annotation", with: @annotation_underline.annotation_id
    fill_in "Color", with: @annotation_underline.color
    fill_in "Height", with: @annotation_underline.height
    fill_in "User", with: @annotation_underline.user_id
    fill_in "Width", with: @annotation_underline.width
    fill_in "X", with: @annotation_underline.x
    fill_in "Y", with: @annotation_underline.y
    click_on "Create Annotation underline"

    assert_text "Annotation underline was successfully created"
    click_on "Back"
  end

  test "updating a Annotation underline" do
    visit annotation_underlines_url
    click_on "Edit", match: :first

    fill_in "Annotation", with: @annotation_underline.annotation_id
    fill_in "Color", with: @annotation_underline.color
    fill_in "Height", with: @annotation_underline.height
    fill_in "User", with: @annotation_underline.user_id
    fill_in "Width", with: @annotation_underline.width
    fill_in "X", with: @annotation_underline.x
    fill_in "Y", with: @annotation_underline.y
    click_on "Update Annotation underline"

    assert_text "Annotation underline was successfully updated"
    click_on "Back"
  end

  test "destroying a Annotation underline" do
    visit annotation_underlines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Annotation underline was successfully destroyed"
  end
end
