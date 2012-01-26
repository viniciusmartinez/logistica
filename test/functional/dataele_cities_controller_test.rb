require 'test_helper'

class DataeleCitiesControllerTest < ActionController::TestCase
  setup do
    @dataele_city = dataele_cities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataele_cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataele_city" do
    assert_difference('DataeleCity.count') do
      post :create, dataele_city: @dataele_city.attributes
    end

    assert_redirected_to dataele_city_path(assigns(:dataele_city))
  end

  test "should show dataele_city" do
    get :show, id: @dataele_city.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataele_city.to_param
    assert_response :success
  end

  test "should update dataele_city" do
    put :update, id: @dataele_city.to_param, dataele_city: @dataele_city.attributes
    assert_redirected_to dataele_city_path(assigns(:dataele_city))
  end

  test "should destroy dataele_city" do
    assert_difference('DataeleCity.count', -1) do
      delete :destroy, id: @dataele_city.to_param
    end

    assert_redirected_to dataele_cities_path
  end
end
