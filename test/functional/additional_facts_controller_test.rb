require 'test_helper'

class AdditionalFactsControllerTest < ActionController::TestCase
  setup do
    @additional_fact = additional_facts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:additional_facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create additional_fact" do
    assert_difference('AdditionalFact.count') do
      post :create, additional_fact: @additional_fact.attributes
    end

    assert_redirected_to additional_fact_path(assigns(:additional_fact))
  end

  test "should show additional_fact" do
    get :show, id: @additional_fact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @additional_fact
    assert_response :success
  end

  test "should update additional_fact" do
    put :update, id: @additional_fact, additional_fact: @additional_fact.attributes
    assert_redirected_to additional_fact_path(assigns(:additional_fact))
  end

  test "should destroy additional_fact" do
    assert_difference('AdditionalFact.count', -1) do
      delete :destroy, id: @additional_fact
    end

    assert_redirected_to additional_facts_path
  end
end
