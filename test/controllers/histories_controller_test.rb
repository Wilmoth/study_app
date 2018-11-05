require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:one)
  end

  test "should get index" do
    get histories_url
    assert_response :success
  end

  test "should get new" do
    get new_history_url
    assert_response :success
  end

  test "should create history" do
    assert_difference('History.count') do
      post histories_url, params: { history: { num_questions: @history.num_questions, score: @history.score, section: @history.section, study_date: @history.study_date, user_name: @history.user_name } }
    end

    assert_redirected_to history_url(History.last)
  end

  test "should show history" do
    get history_url(@history)
    assert_response :success
  end

  test "should get edit" do
    get edit_history_url(@history)
    assert_response :success
  end

  test "should update history" do
    patch history_url(@history), params: { history: { num_questions: @history.num_questions, score: @history.score, section: @history.section, study_date: @history.study_date, user_name: @history.user_name } }
    assert_redirected_to history_url(@history)
  end

  test "should destroy history" do
    assert_difference('History.count', -1) do
      delete history_url(@history)
    end

    assert_redirected_to histories_url
  end
end
