require 'test_helper'

class DataelePlacesControllerTest < ActionController::TestCase
  setup do
    @dataele_place = dataele_places(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataele_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataele_place" do
    assert_difference('DataelePlace.count') do
      post :create, dataele_place: @dataele_place.attributes
    end

    assert_redirected_to dataele_place_path(assigns(:dataele_place))
  end

  test "should show dataele_place" do
    get :show, id: @dataele_place.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataele_place.to_param
    assert_response :success
  end

  test "should update dataele_place" do
    put :update, id: @dataele_place.to_param, dataele_place: @dataele_place.attributes
    assert_redirected_to dataele_place_path(assigns(:dataele_place))
  end

  test "should destroy dataele_place" do
    assert_difference('DataelePlace.count', -1) do
      delete :destroy, id: @dataele_place.to_param
    end

    assert_redirected_to dataele_places_path
  end
end
