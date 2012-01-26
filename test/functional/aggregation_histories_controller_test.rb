require 'test_helper'

class AggregationHistoriesControllerTest < ActionController::TestCase
  setup do
    @aggregation_history = aggregation_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aggregation_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aggregation_history" do
    assert_difference('AggregationHistory.count') do
      post :create, aggregation_history: @aggregation_history.attributes
    end

    assert_redirected_to aggregation_history_path(assigns(:aggregation_history))
  end

  test "should show aggregation_history" do
    get :show, id: @aggregation_history.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aggregation_history.to_param
    assert_response :success
  end

  test "should update aggregation_history" do
    put :update, id: @aggregation_history.to_param, aggregation_history: @aggregation_history.attributes
    assert_redirected_to aggregation_history_path(assigns(:aggregation_history))
  end

  test "should destroy aggregation_history" do
    assert_difference('AggregationHistory.count', -1) do
      delete :destroy, id: @aggregation_history.to_param
    end

    assert_redirected_to aggregation_histories_path
  end
end
