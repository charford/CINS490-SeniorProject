require 'test_helper'

class ApplicantCommentsControllerTest < ActionController::TestCase
  setup do
    @applicant_comment = applicant_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicant_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicant_comment" do
    assert_difference('ApplicantComment.count') do
      post :create, applicant_comment: @applicant_comment.attributes
    end

    assert_redirected_to applicant_comment_path(assigns(:applicant_comment))
  end

  test "should show applicant_comment" do
    get :show, id: @applicant_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @applicant_comment
    assert_response :success
  end

  test "should update applicant_comment" do
    put :update, id: @applicant_comment, applicant_comment: @applicant_comment.attributes
    assert_redirected_to applicant_comment_path(assigns(:applicant_comment))
  end

  test "should destroy applicant_comment" do
    assert_difference('ApplicantComment.count', -1) do
      delete :destroy, id: @applicant_comment
    end

    assert_redirected_to applicant_comments_path
  end
end
