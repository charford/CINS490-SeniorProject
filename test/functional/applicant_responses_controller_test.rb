require 'test_helper'

class ApplicantResponsesControllerTest < ActionController::TestCase
  setup do
    @applicant_response = applicant_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicant_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicant_response" do
    assert_difference('ApplicantResponse.count') do
      post :create, applicant_response: @applicant_response.attributes
    end

    assert_redirected_to applicant_response_path(assigns(:applicant_response))
  end

  test "should show applicant_response" do
    get :show, id: @applicant_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @applicant_response
    assert_response :success
  end

  test "should update applicant_response" do
    put :update, id: @applicant_response, applicant_response: @applicant_response.attributes
    assert_redirected_to applicant_response_path(assigns(:applicant_response))
  end

  test "should destroy applicant_response" do
    assert_difference('ApplicantResponse.count', -1) do
      delete :destroy, id: @applicant_response
    end

    assert_redirected_to applicant_responses_path
  end
end
