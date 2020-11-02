require "application_system_test_case"

class AnnotationCirclesTest < ApplicationSystemTestCase
  setup do
    @annotation_circle = annotation_circles(:one)
  end

  test "visiting the index" do
    visit annotation_circles_url
    assert_selector "h1", text: "Annotation Circles"
  end

  test "creating a Annotation circle" do
    visit annotation_circles_url
    click_on "New Annotation Circle"

    fill_in "Annotation", with: @annotation_circle.annotation_id
    fill_in "Color", with: @annotation_circle.color
    fill_in "Height", with: @annotation_circle.height
    fill_in "User", with: @annotation_circle.user_id
    fill_in "Width", with: @annotation_circle.width
    fill_in "X", with: @annotation_circle.x
    fill_in "Y", with: @annotation_circle.y
    click_on "Create Annotation circle"

    assert_text "Annotation circle was successfully created"
    click_on "Back"
  end

  test "updating a Annotation circle" do
    visit annotation_circles_url
    click_on "Edit", match: :first

    fill_in "Annotation", with: @annotation_circle.annotation_id
    fill_in "Color", with: @annotation_circle.color
    fill_in "Height", with: @annotation_circle.height
    fill_in "User", with: @annotation_circle.user_id
    fill_in "Width", with: @annotation_circle.width
    fill_in "X", with: @annotation_circle.x
    fill_in "Y", with: @annotation_circle.y
    click_on "Update Annotation circle"

    assert_text "Annotation circle was successfully updated"
    click_on "Back"
  end

  test "destroying a Annotation circle" do
    visit annotation_circles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Annotation circle was successfully destroyed"
  end
end
