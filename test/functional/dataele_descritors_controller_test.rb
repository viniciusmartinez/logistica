require 'test_helper'

class DataeleDescritorsControllerTest < ActionController::TestCase
  setup do
    @dataele_descritor = dataele_descritors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataele_descritors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataele_descritor" do
    assert_difference('DataeleDescritor.count') do
      post :create, dataele_descritor: @dataele_descritor.attributes
    end

    assert_redirected_to dataele_descritor_path(assigns(:dataele_descritor))
  end

  test "should show dataele_descritor" do
    get :show, id: @dataele_descritor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataele_descritor.to_param
    assert_response :success
  end

  test "should update dataele_descritor" do
    put :update, id: @dataele_descritor.to_param, dataele_descritor: @dataele_descritor.attributes
    assert_redirected_to dataele_descritor_path(assigns(:dataele_descritor))
  end

  test "should destroy dataele_descritor" do
    assert_difference('DataeleDescritor.count', -1) do
      delete :destroy, id: @dataele_descritor.to_param
    end

    assert_redirected_to dataele_descritors_path
  end
end
