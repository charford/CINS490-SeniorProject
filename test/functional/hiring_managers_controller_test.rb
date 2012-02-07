require 'test_helper'

class HiringManagersControllerTest < ActionController::TestCase
  setup do
    @hiring_manager = hiring_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hiring_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hiring_manager" do
    assert_difference('HiringManager.count') do
      post :create, hiring_manager: @hiring_manager.attributes
    end

    assert_redirected_to hiring_manager_path(assigns(:hiring_manager))
  end

  test "should show hiring_manager" do
    get :show, id: @hiring_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hiring_manager
    assert_response :success
  end

  test "should update hiring_manager" do
    put :update, id: @hiring_manager, hiring_manager: @hiring_manager.attributes
    assert_redirected_to hiring_manager_path(assigns(:hiring_manager))
  end

  test "should destroy hiring_manager" do
    assert_difference('HiringManager.count', -1) do
      delete :destroy, id: @hiring_manager
    end

    assert_redirected_to hiring_managers_path
  end
end
