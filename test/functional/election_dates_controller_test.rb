require 'test_helper'

class ElectionDatesControllerTest < ActionController::TestCase
  setup do
    @election_date = election_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:election_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create election_date" do
    assert_difference('ElectionDate.count') do
      post :create, election_date: @election_date.attributes
    end

    assert_redirected_to election_date_path(assigns(:election_date))
  end

  test "should show election_date" do
    get :show, id: @election_date.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @election_date.to_param
    assert_response :success
  end

  test "should update election_date" do
    put :update, id: @election_date.to_param, election_date: @election_date.attributes
    assert_redirected_to election_date_path(assigns(:election_date))
  end

  test "should destroy election_date" do
    assert_difference('ElectionDate.count', -1) do
      delete :destroy, id: @election_date.to_param
    end

    assert_redirected_to election_dates_path
  end
end
