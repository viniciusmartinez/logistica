require 'test_helper'

class EleCandidatesControllerTest < ActionController::TestCase
  setup do
    @ele_candidate = ele_candidates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ele_candidates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ele_candidate" do
    assert_difference('EleCandidate.count') do
      post :create, ele_candidate: @ele_candidate.attributes
    end

    assert_redirected_to ele_candidate_path(assigns(:ele_candidate))
  end

  test "should show ele_candidate" do
    get :show, id: @ele_candidate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ele_candidate.to_param
    assert_response :success
  end

  test "should update ele_candidate" do
    put :update, id: @ele_candidate.to_param, ele_candidate: @ele_candidate.attributes
    assert_redirected_to ele_candidate_path(assigns(:ele_candidate))
  end

  test "should destroy ele_candidate" do
    assert_difference('EleCandidate.count', -1) do
      delete :destroy, id: @ele_candidate.to_param
    end

    assert_redirected_to ele_candidates_path
  end
end
