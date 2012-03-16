require 'test_helper'

class ActiveusersControllerTest < ActionController::TestCase
  setup do
    @activeuser = activeusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activeusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activeuser" do
    assert_difference('Activeuser.count') do
      post :create, activeuser: @activeuser.attributes
    end

    assert_redirected_to activeuser_path(assigns(:activeuser))
  end

  test "should show activeuser" do
    get :show, id: @activeuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activeuser
    assert_response :success
  end

  test "should update activeuser" do
    put :update, id: @activeuser, activeuser: @activeuser.attributes
    assert_redirected_to activeuser_path(assigns(:activeuser))
  end

  test "should destroy activeuser" do
    assert_difference('Activeuser.count', -1) do
      delete :destroy, id: @activeuser
    end

    assert_redirected_to activeusers_path
  end
end
