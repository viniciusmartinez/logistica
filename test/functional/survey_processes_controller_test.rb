require 'test_helper'

class SurveyProcessesControllerTest < ActionController::TestCase
  setup do
    @survey_process = survey_processes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survey_processes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey_process" do
    assert_difference('SurveyProcess.count') do
      post :create, survey_process: @survey_process.attributes
    end

    assert_redirected_to survey_process_path(assigns(:survey_process))
  end

  test "should show survey_process" do
    get :show, id: @survey_process.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey_process.to_param
    assert_response :success
  end

  test "should update survey_process" do
    put :update, id: @survey_process.to_param, survey_process: @survey_process.attributes
    assert_redirected_to survey_process_path(assigns(:survey_process))
  end

  test "should destroy survey_process" do
    assert_difference('SurveyProcess.count', -1) do
      delete :destroy, id: @survey_process.to_param
    end

    assert_redirected_to survey_processes_path
  end
end
