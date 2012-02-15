require 'test_helper'

class MrjsControllerTest < ActionController::TestCase
  setup do
    @mrj = mrjs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mrjs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mrj" do
    assert_difference('Mrj.count') do
      post :create, mrj: @mrj.attributes
    end

    assert_redirected_to mrj_path(assigns(:mrj))
  end

  test "should show mrj" do
    get :show, id: @mrj.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mrj.to_param
    assert_response :success
  end

  test "should update mrj" do
    put :update, id: @mrj.to_param, mrj: @mrj.attributes
    assert_redirected_to mrj_path(assigns(:mrj))
  end

  test "should destroy mrj" do
    assert_difference('Mrj.count', -1) do
      delete :destroy, id: @mrj.to_param
    end

    assert_redirected_to mrjs_path
  end
end
