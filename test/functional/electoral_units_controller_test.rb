require 'test_helper'

class ElectoralUnitsControllerTest < ActionController::TestCase
  setup do
    @electoral_unit = electoral_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:electoral_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create electoral_unit" do
    assert_difference('ElectoralUnit.count') do
      post :create, electoral_unit: @electoral_unit.attributes
    end

    assert_redirected_to electoral_unit_path(assigns(:electoral_unit))
  end

  test "should show electoral_unit" do
    get :show, id: @electoral_unit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @electoral_unit.to_param
    assert_response :success
  end

  test "should update electoral_unit" do
    put :update, id: @electoral_unit.to_param, electoral_unit: @electoral_unit.attributes
    assert_redirected_to electoral_unit_path(assigns(:electoral_unit))
  end

  test "should destroy electoral_unit" do
    assert_difference('ElectoralUnit.count', -1) do
      delete :destroy, id: @electoral_unit.to_param
    end

    assert_redirected_to electoral_units_path
  end
end
