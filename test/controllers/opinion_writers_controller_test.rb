require 'test_helper'

class OpinionWritersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opinion_writer = opinion_writers(:one)
  end

  test "should get index" do
    get opinion_writers_url
    assert_response :success
  end

  test "should get new" do
    get new_opinion_writer_url
    assert_response :success
  end

  test "should create opinion_writer" do
    assert_difference('OpinionWriter.count') do
      post opinion_writers_url, params: { opinion_writer: { name: @opinion_writer.name, position: @opinion_writer.position, publication_id: @opinion_writer.publication_id, title: @opinion_writer.title, work: @opinion_writer.work } }
    end

    assert_redirected_to opinion_writer_url(OpinionWriter.last)
  end

  test "should show opinion_writer" do
    get opinion_writer_url(@opinion_writer)
    assert_response :success
  end

  test "should get edit" do
    get edit_opinion_writer_url(@opinion_writer)
    assert_response :success
  end

  test "should update opinion_writer" do
    patch opinion_writer_url(@opinion_writer), params: { opinion_writer: { name: @opinion_writer.name, position: @opinion_writer.position, publication_id: @opinion_writer.publication_id, title: @opinion_writer.title, work: @opinion_writer.work } }
    assert_redirected_to opinion_writer_url(@opinion_writer)
  end

  test "should destroy opinion_writer" do
    assert_difference('OpinionWriter.count', -1) do
      delete opinion_writer_url(@opinion_writer)
    end

    assert_redirected_to opinion_writers_url
  end
end
