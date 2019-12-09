require 'test_helper'

class WireStoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wire_story = wire_stories(:one)
  end

  test "should get index" do
    get wire_stories_url
    assert_response :success
  end

  test "should get new" do
    get new_wire_story_url
    assert_response :success
  end

  test "should create wire_story" do
    assert_difference('WireStory.count') do
      post wire_stories_url, params: { wire_story: { body: @wire_story.body, category_code: @wire_story.category_code, category_name: @wire_story.category_name, content_id: @wire_story.content_id, credit: @wire_story.credit, issue_id: @wire_story.issue_id, page_ref_code: @wire_story.page_ref_code, page_ref_name: @wire_story.page_ref_name, send_date: @wire_story.send_date, source: @wire_story.source, title: @wire_story.title } }
    end

    assert_redirected_to wire_story_url(WireStory.last)
  end

  test "should show wire_story" do
    get wire_story_url(@wire_story)
    assert_response :success
  end

  test "should get edit" do
    get edit_wire_story_url(@wire_story)
    assert_response :success
  end

  test "should update wire_story" do
    patch wire_story_url(@wire_story), params: { wire_story: { body: @wire_story.body, category_code: @wire_story.category_code, category_name: @wire_story.category_name, content_id: @wire_story.content_id, credit: @wire_story.credit, issue_id: @wire_story.issue_id, page_ref_code: @wire_story.page_ref_code, page_ref_name: @wire_story.page_ref_name, send_date: @wire_story.send_date, source: @wire_story.source, title: @wire_story.title } }
    assert_redirected_to wire_story_url(@wire_story)
  end

  test "should destroy wire_story" do
    assert_difference('WireStory.count', -1) do
      delete wire_story_url(@wire_story)
    end

    assert_redirected_to wire_stories_url
  end
end
