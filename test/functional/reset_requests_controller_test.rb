require 'test_helper'

class ResetRequestsControllerTest < ActionController::TestCase
  setup do
    @reset_request = reset_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reset_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reset_request" do
    assert_difference('ResetRequest.count') do
      post :create, reset_request: @reset_request.attributes
    end

    assert_redirected_to reset_request_path(assigns(:reset_request))
  end

  test "should show reset_request" do
    get :show, id: @reset_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reset_request
    assert_response :success
  end

  test "should update reset_request" do
    put :update, id: @reset_request, reset_request: @reset_request.attributes
    assert_redirected_to reset_request_path(assigns(:reset_request))
  end

  test "should destroy reset_request" do
    assert_difference('ResetRequest.count', -1) do
      delete :destroy, id: @reset_request
    end

    assert_redirected_to reset_requests_path
  end
end
