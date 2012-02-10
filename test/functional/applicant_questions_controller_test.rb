require 'test_helper'

class ApplicantQuestionsControllerTest < ActionController::TestCase
  setup do
    @applicant_question = applicant_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicant_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicant_question" do
    assert_difference('ApplicantQuestion.count') do
      post :create, applicant_question: @applicant_question.attributes
    end

    assert_redirected_to applicant_question_path(assigns(:applicant_question))
  end

  test "should show applicant_question" do
    get :show, id: @applicant_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @applicant_question
    assert_response :success
  end

  test "should update applicant_question" do
    put :update, id: @applicant_question, applicant_question: @applicant_question.attributes
    assert_redirected_to applicant_question_path(assigns(:applicant_question))
  end

  test "should destroy applicant_question" do
    assert_difference('ApplicantQuestion.count', -1) do
      delete :destroy, id: @applicant_question
    end

    assert_redirected_to applicant_questions_path
  end
end
