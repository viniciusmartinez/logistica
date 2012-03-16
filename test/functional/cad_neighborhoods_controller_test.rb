require 'test_helper'

class CadNeighborhoodsControllerTest < ActionController::TestCase
  setup do
    @cad_neighborhood = cad_neighborhoods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cad_neighborhoods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cad_neighborhood" do
    assert_difference('CadNeighborhood.count') do
      post :create, cad_neighborhood: @cad_neighborhood.attributes
    end

    assert_redirected_to cad_neighborhood_path(assigns(:cad_neighborhood))
  end

  test "should show cad_neighborhood" do
    get :show, id: @cad_neighborhood.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cad_neighborhood.to_param
    assert_response :success
  end

  test "should update cad_neighborhood" do
    put :update, id: @cad_neighborhood.to_param, cad_neighborhood: @cad_neighborhood.attributes
    assert_redirected_to cad_neighborhood_path(assigns(:cad_neighborhood))
  end

  test "should destroy cad_neighborhood" do
    assert_difference('CadNeighborhood.count', -1) do
      delete :destroy, id: @cad_neighborhood.to_param
    end

    assert_redirected_to cad_neighborhoods_path
  end
end
