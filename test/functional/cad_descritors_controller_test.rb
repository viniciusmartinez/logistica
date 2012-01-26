require 'test_helper'

class CadDescritorsControllerTest < ActionController::TestCase
  setup do
    @cad_descritor = cad_descritors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cad_descritors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cad_descritor" do
    assert_difference('CadDescritor.count') do
      post :create, cad_descritor: @cad_descritor.attributes
    end

    assert_redirected_to cad_descritor_path(assigns(:cad_descritor))
  end

  test "should show cad_descritor" do
    get :show, id: @cad_descritor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cad_descritor.to_param
    assert_response :success
  end

  test "should update cad_descritor" do
    put :update, id: @cad_descritor.to_param, cad_descritor: @cad_descritor.attributes
    assert_redirected_to cad_descritor_path(assigns(:cad_descritor))
  end

  test "should destroy cad_descritor" do
    assert_difference('CadDescritor.count', -1) do
      delete :destroy, id: @cad_descritor.to_param
    end

    assert_redirected_to cad_descritors_path
  end
end
