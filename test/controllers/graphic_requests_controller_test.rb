require 'test_helper'

class GraphicRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @graphic_request = graphic_requests(:one)
  end

  test "should get index" do
    get graphic_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_graphic_request_url
    assert_response :success
  end

  test "should create graphic_request" do
    assert_difference('GraphicRequest.count') do
      post graphic_requests_url, params: { graphic_request: { date: @graphic_request.date, description: @graphic_request.description, person_in_charge: @graphic_request.person_in_charge, requester: @graphic_request.requester, status: @graphic_request.status, title: @graphic_request.title } }
    end

    assert_redirected_to graphic_request_url(GraphicRequest.last)
  end

  test "should show graphic_request" do
    get graphic_request_url(@graphic_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_graphic_request_url(@graphic_request)
    assert_response :success
  end

  test "should update graphic_request" do
    patch graphic_request_url(@graphic_request), params: { graphic_request: { date: @graphic_request.date, description: @graphic_request.description, person_in_charge: @graphic_request.person_in_charge, requester: @graphic_request.requester, status: @graphic_request.status, title: @graphic_request.title } }
    assert_redirected_to graphic_request_url(@graphic_request)
  end

  test "should destroy graphic_request" do
    assert_difference('GraphicRequest.count', -1) do
      delete graphic_request_url(@graphic_request)
    end

    assert_redirected_to graphic_requests_url
  end
end
