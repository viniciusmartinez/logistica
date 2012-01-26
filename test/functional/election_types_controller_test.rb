require 'test_helper'

class ElectionTypesControllerTest < ActionController::TestCase
  setup do
    @election_type = election_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:election_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create election_type" do
    assert_difference('ElectionType.count') do
      post :create, election_type: @election_type.attributes
    end

    assert_redirected_to election_type_path(assigns(:election_type))
  end

  test "should show election_type" do
    get :show, id: @election_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @election_type.to_param
    assert_response :success
  end

  test "should update election_type" do
    put :update, id: @election_type.to_param, election_type: @election_type.attributes
    assert_redirected_to election_type_path(assigns(:election_type))
  end

  test "should destroy election_type" do
    assert_difference('ElectionType.count', -1) do
      delete :destroy, id: @election_type.to_param
    end

    assert_redirected_to election_types_path
  end
end
